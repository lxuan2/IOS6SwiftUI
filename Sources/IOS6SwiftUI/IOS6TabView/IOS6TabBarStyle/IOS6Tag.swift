//
//  IOS6Tag.swift
//  IOS6
//
//  Created by Xuan Li on 7/17/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct _IOS6TagEnvironmentKey: EnvironmentKey {
    static let defaultValue: AnyHashable? = nil
}

extension EnvironmentValues {
    var _ios6Tag: AnyHashable? {
        get {
            return self[_IOS6TagEnvironmentKey.self]
        }
        set {
            self[_IOS6TagEnvironmentKey.self] = newValue
        }
    }
}

public extension View {
    func ios6Tag<V>(_ tag: V) -> some View where V : Hashable {
        environment(\._ios6Tag, tag)
    }
}
