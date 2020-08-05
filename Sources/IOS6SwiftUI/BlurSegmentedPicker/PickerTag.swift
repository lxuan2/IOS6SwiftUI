//
//  PickerTag.swift
//  IOS6
//
//  Created by Xuan Li on 8/5/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

public struct PickerTag: ViewModifier {
    @Environment(\.pickerItem) private var pickerItem
    private let id: AnyHashable
    
    public func body(content: Content) -> some View {
        var scale: Bool
        var opacity: Bool
        var highlight: Bool
        let selected = pickerItem.selection == id
        
        switch pickerItem.state {
        case .idle:
            scale = false
            opacity = false
            highlight = selected
        case .active:
            scale = selected
            opacity = false
            highlight = selected
        case .quiteActive(let startSelection):
            let backSelected = startSelection == id
            scale = false
            opacity = selected && !backSelected
            highlight = backSelected
        }
        return
            Button(action: {print("DDDDD")}) {
                content
                    .foregroundColor(.white)
                    .colorMultiply(highlight ? .primary : .secondary)
                    .transformEnvironment(\.colorScheme) { $0 = highlight ? .dark : $0 }
                    .opacity(opacity ? 0.5 : 1)
                    .scaleEffect(scale ? 0.95 : 1)
                    .animation(.easeInOut(duration: 0.2))
                    .anchorPreference(key: BlurSegmentedPickerPreferenceKey.self, value: .bounds, transform: { [BlurSegmentedPickerItemData(id: self.id as AnyHashable, bounds: $0)] })
        }
    }
    
    public init(_ tag: AnyHashable) {
        self.id = tag
    }
}

extension View {
    @inlinable public func pickerTag<V>(_ tag: V) -> some View where V : Hashable {
        modifier(PickerTag(tag))
    }
}
