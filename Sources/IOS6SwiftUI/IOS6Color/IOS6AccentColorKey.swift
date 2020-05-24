//
//  IOS6AccentColorKey.swift
//  IOS6
//
//  Created by Xuan Li on 5/24/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct IOS6AccentColorKey: EnvironmentKey {
    static var defaultValue: Color? = nil
}

extension EnvironmentValues {
    var ios6AccentColor: Color? {
        get { return self[IOS6AccentColorKey.self] }
        set { self[IOS6AccentColorKey.self] = newValue }
    }
}

extension View {
    
    /// Sets the accent color for this view and the views it contains when IOS6
    /// foreground color is applied. Animatable)
    ///
    /// IOS6 accent color is only used when IOS6 foreground color is applied.
    ///
    /// - Parameter accentColor: The color to use as an accent color. If `nil`,
    ///   the accent color depends on given IOS6 foreground color.
    func ios6AccentColor(_ accentColor: Color?) -> some View {
        environment(\.ios6AccentColor, accentColor)
    }
}


