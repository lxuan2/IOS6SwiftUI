//
//  _IOS6NavigationStackKey.swift
//  IOS6
//
//  Created by Xuan Li on 5/24/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct _IOS6NavigationStackHolder {
    weak var value: _IOS6NavigationStack?
}

struct _IOS6NavigationStackKey: EnvironmentKey {
    static var defaultValue: _IOS6NavigationStackHolder = _IOS6NavigationStackHolder(value: nil)
}

extension EnvironmentValues {
    var _ios6NavigationStack: _IOS6NavigationStack? {
        get { return self[_IOS6NavigationStackKey.self].value }
        set { self[_IOS6NavigationStackKey.self].value = newValue }
    }
}
