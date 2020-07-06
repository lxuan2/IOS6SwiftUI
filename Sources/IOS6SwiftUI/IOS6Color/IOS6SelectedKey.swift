//
//  IOS6SelectedKey.swift
//  IOS6
//
//  Created by Xuan Li on 6/21/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

/// `Private API`:
/// A Environment Key indicates selecting state.
struct _IOS6IsSelectedKey: EnvironmentKey {
    static var defaultValue: Bool = false
}

extension EnvironmentValues {
    /// `Private API`:
    /// A Environment Value indicates selecting state.
    var _ios6IsSelected: Bool {
        get { self[_IOS6IsSelectedKey.self] }
        set { self[_IOS6IsSelectedKey.self] = newValue }
    }
}
