//
//  _IOS6FormSectionFontBold.swift
//  IOS6
//
//  Created by Xuan Li on 7/12/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct _IOS6FormSectionFontBold: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.headline.weight(.bold))
            .foregroundColor(Color(red: 76/255.0, green: 86/255.0, blue: 108/255.0))
            .etched(isDown: false, color: Color.white)
            .listRowInsets(EdgeInsets(top: 7.5, leading: 18.5, bottom: 8, trailing: 18.5))
    }
}

extension View {
    public func ios6FormSectionFontBold() -> some View {
        modifier(_IOS6FormSectionFontBold())
    }
}

struct IOS6SectionFormCommenter_Previews: PreviewProvider {
    static var previews: some View {
        Text("test")
            .ios6FormSectionFontBold()
    }
}
