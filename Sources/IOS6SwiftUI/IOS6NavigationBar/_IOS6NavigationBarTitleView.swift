//
//  _IOS6NavigationBarTitle.swift
//  IOS6
//
//  Created by Xuan Li on 4/25/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct _IOS6NavigationBarTitleView: View {
    var title: String
    
    var body: some View {
        ZStack {
            Text(title)
                .foregroundColor(Color.black.opacity(0.5))
                .offset(x: 0, y: -1.1)
            Text(title)
                .foregroundColor(.white)
        }
        .scaledFont(size: 20, weight: .bold)
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

struct ScaledFont: ViewModifier {
    @Environment(\.sizeCategory) var sizeCategory
    var size: CGFloat
    var weight: Font.Weight

    func body(content: Content) -> some View {
       let scaledSize = UIFontMetrics.default.scaledValue(for: size)
        return content.font(.system(size: scaledSize, weight: weight))
    }
}

@available(iOS 13, macCatalyst 13, tvOS 13, watchOS 6, *)
extension View {
    /// Set the font with size and weight and automatically scale font
    /// based on system control
    /// - Parameters:
    ///   - size: Font size
    ///   - weight: Font weight
    /// - Returns: A text view that uses the system control font value and the font value you supply.
    func scaledFont(size: CGFloat, weight: Font.Weight = .regular) -> some View {
        return self.modifier(ScaledFont(size: size, weight: weight))
    }
}
