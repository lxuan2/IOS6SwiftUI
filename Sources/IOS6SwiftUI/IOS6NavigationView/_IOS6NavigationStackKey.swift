//
//  _IOS6NavigationStackKey.swift
//  IOS6
//
//  Created by Xuan Li on 5/24/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct _IOS6NavigationStackKey: EnvironmentKey {
    static var defaultValue: _IOS6NavigationStack? = nil
}

extension EnvironmentValues {
    var _ios6NavigationStack: _IOS6NavigationStack? {
        get { return self[_IOS6NavigationStackKey.self] }
        set { self[_IOS6NavigationStackKey.self] = newValue }
    }
}
