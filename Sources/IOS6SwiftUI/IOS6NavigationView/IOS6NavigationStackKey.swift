//
//  IOS6NavigationStackKey.swift
//  IOS6
//
//  Created by Xuan Li on 5/24/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct IOS6NavigationStackKey: EnvironmentKey {
    static var defaultValue: IOS6NavigationStack? = nil
}

extension EnvironmentValues {
    var ios6NavigationStack: IOS6NavigationStack? {
        get { return self[IOS6NavigationStackKey.self] }
        set { self[IOS6NavigationStackKey.self] = newValue }
    }
}
