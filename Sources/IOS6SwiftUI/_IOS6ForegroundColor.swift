//
//  _IOS6ForegroundColor.swift
//  IOS6
//
//  Created by Xuan Li on 5/24/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

/// A foreground color view modifer set all view inside with
/// `regular` or `active` color with animation.
struct _IOS6ForegroundColor: ViewModifier {
    @Environment(\.ios6ButtonSelected) private var isSelected
    let regular: Color
    let active: Color?
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .colorMultiply(isSelected ? active ?? Color.accentColor : regular)
    }
}

extension View {
    
    /// Sets the color that the view uses for foreground elements
    /// for both IOS6 active color is `nil` and existing. (Animatable)
    ///
    /// Use this method to detect foreground color change from IOS6Button.
    /// `Note`: This is not a perfect implementation for foreground color.
    /// Everything inside is colored including images.
    ///
    /// - Parameters :
    ///     - regular: The color to use as an foreground color when
    ///     IOS6 active color is `nil`.
    ///     - active: The color to use as foreground color when IOS6
    ///     active color exists. If active is `nil`, the active color is used.
    public func ios6ForegroundColor(regular: Color, active: Color?) -> some View {
        modifier(_IOS6ForegroundColor(regular: regular, active: active))
    }
    
    /// Sets the color that the view uses for foreground elements
    /// when IOS6 active color is `nil`. (Animatable)
    ///
    /// Use this method to detect foreground color change from IOS6Button.
    /// `Note`: This is not a perfect implementation for foreground color.
    /// Everything inside is colored including images.
    ///
    /// - Parameter regular: The color to use as an foreground
    ///   color when IOS6 active color is `nil`.
    public func ios6ForegroundColor(_ regular: Color) -> some View {
        modifier(_IOS6ForegroundColor(regular: regular, active: nil))
    }
}

