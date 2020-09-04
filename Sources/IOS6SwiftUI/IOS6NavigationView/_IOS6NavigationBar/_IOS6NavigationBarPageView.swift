//
//  _IOS6NavigationBarPageView.swift
//  IOS6
//
//  Created by Xuan Li on 4/25/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

/// `Private API`:
struct _IOS6NavigationBarPageView<Appearance: IOS6NavigationAppearance>: View {
    var title: String?
    var backTitle: String?
    var noBackTitle: Bool
    var dismiss: () -> Void
    let appearance: Appearance
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        ZStack {
            HStack {
                if !self.noBackTitle {
                    Button(self.backTitle ?? "Back") {
                        self.dismiss()
                    }
                    .buttonStyle(_IOS6NavigationBackButtonStyle(appearance: appearance))
                }
                Spacer()
            }
            
            appearance.makeTextBody(content: Text(self.title ?? ""))
                .scaledFont(size: 20, weight: .bold)
                .layoutPriority(1)
                .position(x: (self.width - 5.5*2) / 2, y: (self.height - 9.5*2) / 2)
        }
        .lineLimit(1)
        .padding(.horizontal, 5.5)
        .padding(.vertical, 9.5)
        .compositingGroup()
        .frame(width: width)
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
    /// - Parameter isDown: A Boolean indicates z axis direction.
    /// - Returns: some View
    public func etched(isDown: Bool = true, color: Color? = nil) -> some View {
        shadow(color: color ?? Color.black.opacity(0.5), radius: 0, x: 0, y: isDown ? -1 : 1)
    }
}

