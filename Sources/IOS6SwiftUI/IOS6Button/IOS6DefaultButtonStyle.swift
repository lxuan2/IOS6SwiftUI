//
//  IOS6DefaultButtonStyle.swift
//  IOS6
//
//  Created by Xuan Li on 7/18/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

public struct IOS6DefaultButtonStyle: ButtonStyle {
    
    public init() {}
    public func makeBody(configuration: IOS6DefaultButtonStyle.Configuration) -> some View {
        _IOS6ButtonStyleButton(configuration: configuration)
    }
    
    private struct _IOS6ButtonStyleButton: View {
        let configuration: IOS6DefaultButtonStyle.Configuration
        @State private var hold: Bool = false
        @Environment(\.isEnabled) private var isEnabled
        
        var body: some View {
            let pressed = configuration.isPressed || hold
            return configuration.label
                .environment(\.ios6ButtonSelected, pressed)
                .opacity(self.isEnabled ? 1 : 0.9)
                .onPreferenceChange(_IOS6HoldPressPreferenceKey.self) { value in
                    withAnimation(self.hold && !value ? Animation.spring().delay(0.35) : .none) {
                        self.hold = value
                    }
            }
        }
    }
}

public struct IOS6ButtonSelected: EnvironmentKey {
    public static var defaultValue: Bool = false
}

public extension EnvironmentValues {
    var ios6ButtonSelected: Bool {
        get { return self[IOS6ButtonSelected.self] }
        set { self[IOS6ButtonSelected.self] = newValue }
    }
}

struct _IOS6HoldPressPreferenceKey: PreferenceKey {
    typealias Value = Bool
    
    static var defaultValue: Value = false
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue() || value
    }
}

extension View {
    func _ios6HoldButtonPress(_ isPressed: Bool) -> some View {
        self.preference(key: _IOS6HoldPressPreferenceKey.self, value: isPressed)
    }
}
