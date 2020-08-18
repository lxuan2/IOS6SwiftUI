//
//  _IOS6IsEnabled.swift
//  IOS6
//
//  Created by Xuan Li on 6/21/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

/// `Private API`:
/// A Environment Key indicates selecting state.
struct _IOS6IsEnabledKey: EnvironmentKey {
    static var defaultValue: Bool = true
}

extension EnvironmentValues {
    /// `Private API`:
    /// A Environment Value indicates selecting state.
    var _ios6IsEnabled: Bool {
        get { self[_IOS6IsEnabledKey.self] }
        set { self[_IOS6IsEnabledKey.self] = newValue }
    }
}

extension View {
    func _ios6Disabled(_ disabled: Bool) -> some View {
        self
            .environment(\._ios6IsEnabled, !disabled)
            .disabled(disabled)
    }
}
