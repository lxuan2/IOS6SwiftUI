//
//  BlurSegmentedPicker.swift
//  IOS6
//
//  Created by Xuan Li on 8/3/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

public struct BlurSegmentedPicker<SelectionValue: Hashable, Content: View>: View {
    @GestureState private var state: BlurSegmentedPickerState = .idle
    @State private var internalSelection: AnyHashable
    @State private var hold: Bool = false
    @Binding var selection: SelectionValue
    let content: Content
    
    public var body: some View {
        HStack(spacing: 30) {
            self.content
        }
        .fixedSize()
        .padding(.horizontal, 21)
        .padding(.vertical, 9.75)
        .foregroundColor(.secondary)
        .font(Font.headline.weight(.semibold))
        .environment(\.pickerItem, .init(selection: internalSelection, state: hold ? .active : state))
        .overlayPreferenceValue(BlurSegmentedPickerPreferenceKey.self) { preferences in
            GeometryReader { self.createTouchLayer($0, preferences) }
        }
        .backgroundPreferenceValue(BlurSegmentedPickerPreferenceKey.self) { preferences in
            GeometryReader {
                self.createBackground($0, preferences)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }
        }
        .background(BlurEffectView(style: .systemUltraThinMaterial).clipShape(Capsule()))
    }
    
    public init(selection: Binding<SelectionValue>, @ViewBuilder content: () -> Content) {
        _selection = selection
        _internalSelection = .init(initialValue: selection.wrappedValue)
        self.content = content()
    }
}

struct BlurSegmentedPicker_Previews: PreviewProvider {
    static var previews: some View {
        BlurSegmentedPicker(selection: .constant(0)) {
            Text("Years").pickerTag(0)
            
            Text("Months").pickerTag(1)
            
            Text("Days").pickerTag(2)
            
            Text("All Photos").pickerTag(3)
        }
    }
}

extension BlurSegmentedPicker {
    func createTouchLayer(_ geometry: GeometryProxy, _ preferences: [BlurSegmentedPickerItemData]) -> some View {
        var region: [RegionData] = []
        for i in preferences {
            let rect = geometry[i.bounds]
            region.append(RegionData(id: i.id, range: (rect.minX - 15)..<(rect.maxX + 15)))
        }
        let gesture =
            DragGesture(minimumDistance: 0, coordinateSpace: .local)
                .updating(self.$state) { value, state, trans in
                    if state.isIdle() {
                        for i in region {
                            if i.id == self.internalSelection, i.range.contains(value.startLocation.x) {
                                state = .active
                                return
                            }
                        }
                        state = .quiteActive(startSelection: self.internalSelection)
                    }
            }.onChanged { value in
                if !self.state.isIdle() {
                    for i in region {
                        if i.range.contains(value.location.x) {
                            if self.internalSelection != i.id {
                                self.internalSelection = i.id
                            }
                            break
                        }
                    }
                }
            }.onEnded { value in
                var slt = self.internalSelection
                for i in region {
                    if i.range.contains(value.predictedEndLocation.x) {
                        self.internalSelection = i.id
                        slt = i.id
                        break
                    }
                }
                if let select = slt as? SelectionValue {
                    self.selection = select
                } else {
                    for j in region {
                        if let x = j.id as? SelectionValue {
                            self.selection = x
                            self.internalSelection = x
                            break
                        }
                    }
                }
                
                self.hold = true
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                    self.hold = false
                }
        }
        return
            Color.clear
                .contentShape(Rectangle())
                .simultaneousGesture(gesture)
    }
}

extension BlurSegmentedPicker {
    func createBackground(_ geometry: GeometryProxy, _ preferences: [BlurSegmentedPickerItemData]) -> some View {
        let horizontal: CGFloat = 17
        var bounds = CGRect(x: 0, y: 0, width: 0, height: 0)
        var pad: CGFloat = 4
        
        var slt: AnyHashable
        switch state {
        case .quiteActive(let x):
            slt = x
        default:
            slt = internalSelection
        }
        if let select = preferences.first(where: {
            $0.id == slt
        }) {
            let press = state.isActive() || hold
            let bd = geometry[select.bounds]
            let ratio: CGFloat = press ? 0.95 : 1
            pad += (geometry.size.height - pad * 2) * (1 - ratio) / 2
            bounds = CGRect(x: bd.minX - horizontal + (bd.width + horizontal * 2) * (1 - ratio) / 2,
                            y: 0,
                            width: (bd.width + horizontal * 2) * ratio,
                            height: 0)
        } else {
            bounds = CGRect(x: 0, y: 0, width: 0, height: 0)
            if !preferences.isEmpty {
                DispatchQueue.main.async {
                    self.internalSelection = preferences[0].id
                }
            }
        }
        return
            VibrancyEffectView(blurEffect: .systemUltraThinMaterial, style: .tertiaryLabel, content: Capsule())
                .frame(width: bounds.width)
                .padding(.vertical, pad)
                .offset(x: bounds.minX, y: 0)
                .animation(.easeInOut(duration: 0.18))
    }
}

extension BlurSegmentedPicker {
    struct RegionData {
        let id: AnyHashable
        let range: Range<CGFloat>
    }
}
