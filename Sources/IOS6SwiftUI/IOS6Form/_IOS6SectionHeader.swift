//
//  _IOS6SectionHeader.swift
//  IOS6
//
//  Created by Xuan Li on 7/12/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct _IOS6SectionHeader: ViewModifier {
    
    func body(content: Content) -> some View {
        Color(red: 180/255.0, green: 192/255.0, blue: 197/255.0).overlay(
        LinearGradient(gradient: Gradient(colors: [
            Color(red: 150/255.0, green: 164/255.0, blue: 174/255.0),
            Color(red: 162/255.0, green: 173/255.0, blue: 183/255.0),
            Color(red: 178/255.0, green: 188/255.0, blue: 195/255.0),
            Color(red: 183/255.0, green: 192/255.0, blue: 199/255.0),
            Color(red: 183/255.0, green: 192/255.0, blue: 199/255.0),
        ]), startPoint: .top, endPoint: .bottom))
            .overlay(VStack(spacing: 0) {
                Color(red: 140/255.0, green: 150/255.0, blue: 158/255.0).frame(height: 1)
                Color(red: 171/255.0, green: 184/255.0, blue: 192/255.0).frame(height: 1)
            }, alignment: .top)
            .overlay(
                Color(red: 155/255.0, green: 161/255.0, blue: 168/255.0).frame(height: 1)
                , alignment: .bottom)
            .overlay(content.foregroundColor(.white).etched(isDown: false).padding(.init(top: 7, leading: 14, bottom: 7, trailing: 14)).font(Font.headline.weight(.bold)), alignment: .leading)
            .padding(.top, -1)
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
    }
}

extension View {
    public func ios6SectionHeader() -> some View {
        modifier(_IOS6SectionHeader())
    }
}

struct IOS6SectionHeader_Previews: PreviewProvider {
    static var previews: some View {
        Text("test")
            .ios6SectionHeader()
    }
}
