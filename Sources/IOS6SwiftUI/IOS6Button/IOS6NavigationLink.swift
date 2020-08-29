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
    @Environment(\._ios6NavigationLinkType) var type
    @Environment(\._ios6NavigationIdGenerator) var generator
    @State private var id: Int? = nil
    @State private var hold: Bool = false
    private let label: Label
    private let destination: Destination
    
    public var body: some View {
        let bind: Binding<Int?> = .init(get: { self.id }, set: { value in
            self.hold = false
            DispatchQueue.main.asyncAfter(deadline: .now() + IOS6StackNavigationViewStyle.IOS6StackNavigationView.self.transTime + IOS6StackNavigationViewStyle.IOS6StackNavigationView.self.delay) { self.id = value }
        })
        return Button(action: {
            if let g = self.generator {
                self.hold = true
                self.id = g()
            }
        }) {
            label
                ._ios6IsNavigationLink(true)
                ._ios6HoldButtonPress(hold)
        }
        .modifier(IOS6NavigationLinkPreference(destination: destination, type: type, id: bind))
        .disabled(generator == nil)
    }
    
    /// A initializer with desination view and label view
    ///
    /// Default button style is given with highlight color: blue.
    /// - Parameters:
    ///   - destination: a view that will be presented.
    ///   - label: a content view.
    public init(destination: Destination, label: @escaping () -> Label) {
        self.destination = destination
        self.label = label()
    }
    
    func isDetailLink(_ isDetailLink: Bool) -> some View {
        environment(\._ios6NavigationLinkType, isDetailLink ? .detail : .master)
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

struct _IOS6NavigationisLinkPreferenceKey: PreferenceKey {
    typealias Value = Bool
    
    static var defaultValue: Value = false
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue() || value
    }
}

extension View {
    func _ios6IsNavigationLink(_ isPressed: Bool) -> some View {
        self.preference(key: _IOS6NavigationisLinkPreferenceKey.self, value: isPressed)
    }
}

struct _IOS6NavigationLinkPreferenceKey: PreferenceKey {
    typealias Value = [IOS6NavigationViewStyleComponentConfiguration.Link]
    
    static var defaultValue: Value = []
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value.append(contentsOf: nextValue())
    }
}

struct IOS6NavigationLinkPreference<Destination: View>: ViewModifier {
    let destination: Destination
    let type: IOS6NavigationViewStyleComponentConfiguration.LinkType
    @Binding var id: Int?
    
    func body(content: Content) -> some View {
        content
            .preference(key: _IOS6NavigationLinkPreferenceKey.self,
                        value: id == nil ? [] : [IOS6NavigationViewStyleComponentConfiguration.Link(destination, type: type, id: $id)])
    }
}
