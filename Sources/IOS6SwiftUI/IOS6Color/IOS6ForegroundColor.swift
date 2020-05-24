//
//  IOS6ForegroundColor.swift
//  IOS6
//
//  Created by Xuan Li on 5/24/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct IOS6ForegroundColor: ViewModifier {
    @Environment(\.ios6AccentColor) private var accentColor
    let color: Color
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .colorMultiply(accentColor == nil ? color : accentColor!)
    }
}

extension View {
    
    /// Sets the color that the view uses for foreground elements
    /// when IOS6 accent color is `nil`. (Animatable)
    ///
    /// Note: This is not a perfect implementation for foreground color.
    /// Everything inside is colored including images.
    ///
    /// - Parameter color: The color to use as an foreground
    ///   color when IOS6 accent color is `nil`.
    func ios6ForegroundColor(_ color: Color) -> some View {
        modifier(IOS6ForegroundColor(color: color))
    }
}
