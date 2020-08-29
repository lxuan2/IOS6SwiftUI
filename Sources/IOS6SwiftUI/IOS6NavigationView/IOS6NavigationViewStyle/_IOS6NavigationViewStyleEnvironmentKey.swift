//
//  _IOS6NavigationViewStyleEnvironmentKey.swift
//  test
//
//  Created by Xuan Li on 8/19/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct _IOS6NavigationViewStyleEnvironmentKey: EnvironmentKey {
    static let defaultValue = _IOS6AnyNavigationViewStyle(IOS6StackNavigationViewStyle())
}

extension EnvironmentValues {
    var _ios6NavigationViewStyle: _IOS6AnyNavigationViewStyle {
        get {
            return self[_IOS6NavigationViewStyleEnvironmentKey.self]
        }
        set {
            self[_IOS6NavigationViewStyleEnvironmentKey.self] = newValue
        }
    }
}

public extension View {
    func ios6NavigationViewStyle<S>(_ style: S) -> some View where S : IOS6NavigationViewStyle {
        environment(\._ios6NavigationViewStyle, _IOS6AnyNavigationViewStyle(style))
    }
}
