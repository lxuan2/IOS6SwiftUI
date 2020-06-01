//
//  _IOS6ToggleColorKey.swift
//  IOS6
//
//  Created by Xuan Li on 5/31/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct _IOS6ToggleColorKey: EnvironmentKey {
    static var defaultValue: Color = Color(red: 0/255.0, green: 127/255.0, blue: 234/255.0)
    // Color(red: 0/255.0, green: 127/255.0, blue: 234/255.0) blue
    // Color(red: 255.0/255.0, green: 127.0/255.0, blue: 2.0/255.0) orange
}

extension EnvironmentValues {
    var _ios6ToggleColor: Color {
        get { return self[_IOS6ToggleColorKey.self] }
        set { self[_IOS6ToggleColorKey.self] = newValue }
    }
}

extension View {
    public func ios6ToggleColor(_ color: Color?) -> some View {
        environment(\._ios6ToggleColor, color ?? Color(red: 0/255.0, green: 127/255.0, blue: 234/255.0))
    }
}
