//
//  IOS6ActiveColorKey.swift
//  IOS6
//
//  Created by Xuan Li on 5/24/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct _IOS6ActiveColorKey: EnvironmentKey {
    static var defaultValue: Color? = nil
}

extension EnvironmentValues {
    var _ios6ActiveColor: Color? {
        get { return self[_IOS6ActiveColorKey.self] }
        set { self[_IOS6ActiveColorKey.self] = newValue }
    }
}

extension View {
    
    /// Sets the active color for this view and the views it contains when IOS6
    /// foreground color is applied. Animatable)
    ///
    /// IOS6 active color is only used when IOS6 foreground color is applied.
    ///
    /// - Parameter color: The color to use as an active color. If `nil`,
    ///   the active color depends on given IOS6 foreground color.
    func _ios6ActiveColor(_ color: Color?) -> some View {
        environment(\._ios6ActiveColor, color)
    }
}


