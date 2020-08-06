//
//  BlurSegmentedPicker.swift
//  IOS6
//
//  Created by Xuan Li on 8/3/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

public struct BlurSegmentedPicker<SelectionValue: Hashable, Content: View>: View {
    @GestureState(resetTransaction: .init(animation: .init(Animation.easeInOut(duration: 0.2).delay(0.1))))
    private var state: BlurSegmentedPickerState = .idle
    @State private var internalSelection: AnyHashable
    @State private var hold: Bool = false
    @Binding var selection: SelectionValue
    let content: Content
    
    public var body: some View {
        HStack(spacing: 30) {
            self.content
        }
        .fixedSize()
        .padding(.vertical, 6)
        .padding(.horizontal, 17)
        .foregroundColor(.secondary)
        .font(Font.headline.weight(.semibold))
        .environment(\.pickerItem, .init(selection: internalSelection, state: hold ? .active : state))
        .backgroundPreferenceValue(BlurSegmentedPickerPreferenceKey.self) { preferences in
            GeometryReader { self.createBackground($0, preferences)}
        }
        .overlayPreferenceValue(BlurSegmentedPickerPreferenceKey.self) { preferences in
            GeometryReader { self.createTouchLayer($0, preferences) }
        }
        .padding(4)
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
                            trans = .init(animation: .easeIn(duration: 0.1))
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
                                withAnimation(.easeIn(duration: 0.2)) {
                                    self.internalSelection = i.id
                                }
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
            }
        return
            Color.clear
            .contentShape(Rectangle())
            .simultaneousGesture(gesture)
    }
}

extension BlurSegmentedPicker {
    func createBackground(_ geometry: GeometryProxy, _ preferences: [BlurSegmentedPickerItemData]) -> some View {
        var leading: CGFloat = 0
        var trailing: CGFloat = 0
        var horizontalPad: CGFloat = 0
        var verticalPad: CGFloat = 0
        
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
            let press = state.isActive()
            let frame = geometry.frame(in: .local)
            let bounds = geometry[select.bounds]
            leading = bounds.minX - frame.minX - 17
            trailing = frame.maxX - bounds.maxX - 17
            horizontalPad = press ? (bounds.width / 2 + 17) * (1 - 0.95) : 0
            verticalPad = press ? frame.size.height * (1 - 0.95) / 2 : 0
        } else {
            if !preferences.isEmpty {
                DispatchQueue.main.async {
                    self.internalSelection = preferences[0].id
                }
            }
        }
        
        return
            VibrancyEffectView(blurEffect: .systemUltraThinMaterial, style: .tertiaryLabel, content: Capsule())
            .padding(.leading, leading)
            .padding(.trailing, trailing)
            .padding(.vertical, verticalPad)
            .padding(.horizontal, horizontalPad)
    }
}

extension BlurSegmentedPicker {
    struct RegionData {
        let id: AnyHashable
        let range: Range<CGFloat>
    }
}
