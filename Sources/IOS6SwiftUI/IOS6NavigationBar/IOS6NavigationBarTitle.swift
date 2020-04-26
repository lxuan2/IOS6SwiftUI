//
//  IOS6NavigationBarTitle.swift
//  IOS6
//
//  Created by Xuan Li on 4/25/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct IOS6NavigationBarTitle: View {
    let title: String?
    
    var body: some View {
        ZStack {
            Text(title ?? "")
                .foregroundColor(Color.black.opacity(0.5))
                .offset(x: 0, y: -1.1)
            Text(title ?? "")
                .foregroundColor(.white)
        }
        .scaledFont(size: 20, weight: .bold)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct IOS6NavigationBarTitle_Previews: PreviewProvider {
    static var previews: some View {
        IOS6NavigationBarTitle(title: "Test")
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
    func scaledFont(size: CGFloat, weight: Font.Weight = .regular) -> some View {
        return self.modifier(ScaledFont(size: size, weight: weight))
    }
}
