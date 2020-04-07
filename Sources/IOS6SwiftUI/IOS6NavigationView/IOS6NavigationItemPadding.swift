//
//  IOS6NavigationItemPadding.swift
//  IOS6
//
//  Created by Xuan Li on 4/7/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct IOS6NavigationItemPaddingModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.vertical, 8)
            .padding(.leading, 9)
    }
}

extension View {
    func IOS6NavigationItemPadding() -> some View {
        self.modifier(IOS6NavigationItemPaddingModifier())
    }
}
