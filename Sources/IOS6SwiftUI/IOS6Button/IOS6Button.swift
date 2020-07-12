//
//  DebounceButton.swift
//  IOS6
//
//  Created by Xuan Li on 5/27/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

/// A control that performs an action when triggered.
///
/// Default debounced behavior is given with 0.1s delay. This prevents
/// too sensitive pressing trigger compared with original button. Prefer
/// to use this in scroll area i.e. IOS6Form. Also allow customized button
/// style.
public struct IOS6Button<Label: View, SubLabel: View>: View {
    @State private var pressing: Bool = false
    private let action: () -> Void
    private let label: (Bool) -> Label
    
    public var body: some View {
        Button(action: {
            DispatchQueue.main.async {
                self.pressing = true
            }
            self.action()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.easeOut(duration: 0.1)) {
                    self.pressing = false
                }
            }
        }, label: {EmptyView()})
            .buttonStyle(_IOS6ButtonStyle() { isPressed in
                self.label(isPressed || self.pressing)
            })
    }
}

extension IOS6Button where SubLabel == Never {
    /// A initializer that provides action behavior and customized label view
    ///
    /// This initializer is designed to allow customized button style.
    /// The `Bool` Value indicates whether the button is pressed.
    ///
    /// - Parameters:
    ///   - action: the action behavior when the control is triggered
    ///   - label: a content view given whether the button is pressed.
    public init(action: @escaping () -> Void, label: @escaping (Bool) -> Label) {
        self.action = action
        self.label = label
    }
}

extension IOS6Button where Label == _IOS6ButtonLabel<SubLabel> {
    /// A initializer that provides action behavior and label view
    ///
    /// Default button style is given with highlight color: blue.
    ///
    /// - Parameters:
    ///   - action: the action behavior when the control is triggered
    ///   - label: a content view.
    ///   - position: the position in IOS6Form / IOS6List section.
    public init(action: @escaping () -> Void, label: @escaping () -> SubLabel, sectionPostion position: IOS6SectionPosition = .none) {
        self.init(action: action, label: { isPressed in _IOS6ButtonLabel(isPressed, label: label(), sectionPostion: position, isLink: false)})
    }
}

struct DebounceButton_Previews: PreviewProvider {
    static var previews: some View {
        IOS6Button(action: {}, label: { _ in Text("Debounce Button")})
    }
}
