//
//  IOS6SelectedKey.swift
//  IOS6
//
//  Created by Xuan Li on 6/21/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct IOS6IsSelectedKey: EnvironmentKey {
    static var defaultValue: Bool = false
}

extension EnvironmentValues {
    public var ios6IsSelected: Bool {
        get { return self[IOS6IsSelectedKey.self] }
        set { self[IOS6IsSelectedKey.self] = newValue }
    }
}
