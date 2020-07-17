//
//  _IOS6TabBarStyleEnvironmentKey.swift
//  IOS6
//
//  Created by Xuan Li on 7/15/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct _IOS6TabBarStyleEnvironmentKey: EnvironmentKey {
    static let defaultValue: _IOS6AnyTabBarStyle = _IOS6AnyTabBarStyle(IOS6BlueDiamondTabBarStyle())
}

extension EnvironmentValues {
    var _ios6TabBarStyle: _IOS6AnyTabBarStyle {
        get {
            return self[_IOS6TabBarStyleEnvironmentKey.self]
        }
        set {
            self[_IOS6TabBarStyleEnvironmentKey.self] = newValue
        }
    }
}

public extension View {
    func ios6TabBarStyle<S>(_ style: S) -> some View where S : IOS6TabBarStyle {
        environment(\._ios6TabBarStyle, _IOS6AnyTabBarStyle(style))
    }
}
