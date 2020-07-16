//
//  IOS6TabBarStyleEnvironmentKey.swift
//  IOS6
//
//  Created by Xuan Li on 7/15/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct IOS6TabBarStyleEnvironmentKey: EnvironmentKey {
    static let defaultValue: IOS6AnyTabBarStyle = IOS6AnyTabBarStyle(IOS6BlueDiamondTabBarStyle())
}

extension EnvironmentValues {
    var ios6TabBarStyle: IOS6AnyTabBarStyle {
        get {
            return self[IOS6TabBarStyleEnvironmentKey.self]
        }
        set {
            self[IOS6TabBarStyleEnvironmentKey.self] = newValue
        }
    }
}

public extension View {
    func ios6TabBarStyle<S>(_ style: S) -> some View where S : IOS6TabBarStyle {
        environment(\.ios6TabBarStyle, IOS6AnyTabBarStyle(style))
    }
}
