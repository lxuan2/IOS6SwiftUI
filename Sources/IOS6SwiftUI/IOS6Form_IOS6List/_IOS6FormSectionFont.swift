//
//  _IOS6SectionFormFooter.swift
//  IOS6
//
//  Created by Xuan Li on 7/12/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct _IOS6FormSectionFont: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.subheadline)
            .foregroundColor(Color(red: 76/255.0, green: 86/255.0, blue: 108/255.0))
            .etched(isDown: false, color: Color.white)
            .listRowInsets(.init(top: 0, leading: 13, bottom: 0, trailing: 13))
    }
}

extension View {
    public func ios6FormSectionFont() -> some View {
        modifier(_IOS6FormSectionFont())
    }
}

struct IOS6SectionFormFooter_Previews: PreviewProvider {
    static var previews: some View {
        Text("test")
            .ios6FormSectionFont()
    }
}
