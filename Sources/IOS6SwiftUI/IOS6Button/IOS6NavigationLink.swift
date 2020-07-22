//
//  IOS6NavigationLink.swift
//  animation
//
//  Created by Xuan Li on 1/22/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI
import Foundation

/// A button that triggers a IOS6 style navigation presentation when pressed.
///
/// This button is similar to IOS6Button. Default debounced behavior is given,
/// and provides selected state by keeping pressing state. Also allow customized
/// button style.
public struct IOS6NavigationLink<Label: View, Destination : View>: View {
    private let label: () -> Label
    private let destination: Destination
    @State private var sheet = false
    @Environment(\._ios6NavigationStack) private var stack
    
    public var body: some View {
        Button(action: {
            if self.stack != nil, !self.stack!.blocking {
                self.sheet = true
                self.stack!.push(isPresent: self.$sheet,
                                 newView: self.destination)
            }
        }) {
            label()
                ._ios6IsNavigationLink(true)
                ._ios6HoldButtonPress(sheet)
        }
        .disabled(stack == nil)
    }
    
    /// A initializer with desination view and label view
    ///
    /// Default button style is given with highlight color: blue.
    /// - Parameters:
    ///   - destination: a view that will be presented.
    ///   - label: a content view.
    public init(destination: Destination, label: @escaping () -> Label) {
        self.destination = destination
        self.label = label
    }
}

struct IOS6NavigationLink_Previews: PreviewProvider {
    static var previews: some View {
        IOS6NavigationView {
            IOS6Form {
                IOS6NavigationLink(destination: Text("Hello World")) {
                    Text("Tap Me")
                }
            }
        }
    }
}

struct _IOS6NavigationLinkPreferenceKey: PreferenceKey {
    typealias Value = Bool
    
    static var defaultValue: Value = false
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue() || value
    }
}

extension View {
    func _ios6IsNavigationLink(_ isPressed: Bool) -> some View {
        self.preference(key: _IOS6NavigationLinkPreferenceKey.self, value: isPressed)
    }
}
