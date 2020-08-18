//
//  IOS6SliderStyleConfiguration.swift
//  Demo
//
//  Created by Xuan Li on 8/18/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

public struct IOS6SliderStyleConfiguration {

    /// A type-erased label of a `IOS6Slider`.
    public struct Label : View {
        
        private var label: AnyView
        
        init<Label: View>(_ label: Label) {
            self.label = AnyView(label)
        }

        /// The type of view representing the body of this view.
        ///
        /// When you create a custom view, Swift infers this type from your
        /// implementation of the required `body` property.
        public var body: some View {
            label
        }
    }

    /// A view that describes the effect of sliding `value`.
    public let minimumValueLabel: IOS6SliderStyleConfiguration.Label
    public let maximumValueLabel: IOS6SliderStyleConfiguration.Label
    
    /// Current projected slider value ranging between 0 and 1.
    public var value: CGFloat {
        get {
            _value.wrappedValue
        }
        nonmutating set {
            _value.wrappedValue = newValue
        }
    }
    
    public let _value: Binding<CGFloat>
    
    public let onEditingChanged: (Bool) -> Void
    
    init<MinLabel: View, MaxLabel: View>(value: Binding<CGFloat>, minimumValueLabel: MinLabel, maximumValueLabel: MaxLabel, onEditingChanged: @escaping (Bool) -> Void) {
        self._value = value
        self.minimumValueLabel = Label(minimumValueLabel)
        self.maximumValueLabel = Label(maximumValueLabel)
        self.onEditingChanged = onEditingChanged
    }
}
