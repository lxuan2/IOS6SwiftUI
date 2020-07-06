//
//  _IOS6NavigationBarTitle.swift
//  IOS6
//
//  Created by Xuan Li on 4/25/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

/// `Private API`:
struct _IOS6NavigationBarTitleView: View {
    var title: String
    
    var body: some View {
        Text(title)
            .foregroundColor(.white)
            .scaledFont(size: 20, weight: .bold)
            .etched()
    }
    
    init(title: String?) {
        self.title = title ?? ""
    }
}

struct IOS6NavigationBarTitle_Previews: PreviewProvider {
    static var previews: some View {
        _IOS6NavigationBarTitleView(title: "Test")
    }
}

/// `Private API`:
/// Scale given font base on system setting.
struct _ScaledFont: ViewModifier {
    @Environment(\.sizeCategory) var sizeCategory
    var size: CGFloat
    var weight: Font.Weight
    
    func body(content: Content) -> some View {
        let scaledSize = UIFontMetrics.default.scaledValue(for: size)
        return content.font(.system(size: scaledSize, weight: weight))
    }
}

extension View {
    /// Set the font with size and weight and automatically scale font
    /// based on system control
    /// - Parameters:
    ///   - size: Font size
    ///   - weight: Font weight
    /// - Returns: A text view that uses the system control font value and the font value you supply.
    public func scaledFont(size: CGFloat, weight: Font.Weight = .regular) -> some View {
        modifier(_ScaledFont(size: size, weight: weight))
    }
    
    /// IOS6 etched Style
    public func etched() -> some View {
        shadow(color: Color.black.opacity(0.5), radius: 0, x: 0, y: -1)
    }
}
