//
//  _IOS6NavigationBar.swift
//  animation
//
//  Created by Xuan Li on 2/4/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct _IOS6NavigationBar: View {
    @Environment(\.isEnabled) private var isEnabled
    
    var body: some View {
        VStack(spacing: 0) {
            Color(red: 233/255, green: 244/255, blue: 255/255)
                .frame(height: 0.55)
            
            LinearGradient(
                gradient:
                Gradient(colors:
                    [Color(red: 89.0/255.0, green: 115.0/255.0, blue: 152.0/255.0),
                     Color(red: 135.0/255.0, green: 156.0/255.0, blue: 183.0/255.0),
                     Color(red: 195.0/255.0, green: 205.0/255.0, blue: 220.0/255.0)]),
                startPoint: .bottom,
                endPoint: .top
            )
            
            Color(red: 69/255, green: 91/255, blue: 125/255)
                .frame(height: 1.1)
        }
            .compositingGroup()
            .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 0.7)
            .overlay(
                GeometryReader { proxy in
                    _IOS6NavigationBarContentView(width: proxy.size.width)
                        .padding(.leading, proxy.safeAreaInsets.leading)
                        .padding(.trailing, proxy.safeAreaInsets.trailing)
                        .opacity(self.isEnabled ? 1 : 0.8)
                }
        )
            .frame(height: 45)
    }
}

struct IOS6NavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        _IOS6NavigationBar()
    }
}
