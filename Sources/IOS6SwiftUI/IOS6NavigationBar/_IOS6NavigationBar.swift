//
//  _IOS6NavigationBar.swift
//  animation
//
//  Created by Xuan Li on 2/4/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

/// `Private API`:
struct _IOS6NavigationBar: View {
    @Environment(\.isEnabled) private var isEnabled
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient:
                    Gradient(colors:
                                [Color(red: 90.0/255.0, green: 116.0/255.0, blue: 153.0/255.0),
                                 Color(red: 143.0/255.0, green: 163.0/255.0, blue: 188.0/255.0),
                                 Color(red: 190.0/255.0, green: 203.0/255.0, blue: 220.0/255.0)]),
                startPoint: .bottom,
                endPoint: .top
            )
            .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 0.7)
            .overlay(
                VStack(spacing: 0) {
                    Color(red: 233/255, green: 244/255, blue: 255/255)
                        .frame(height: 0.5)
                    
                    Spacer()
                    
                    Color(red: 69/255, green: 91/255, blue: 125/255)
                        .frame(height: 1)
                }
            )
            
            GeometryReader { proxy in
                _IOS6NavigationBarContentView(width: proxy.size.width)
                    .padding(.leading, proxy.safeAreaInsets.leading)
                    .padding(.trailing, proxy.safeAreaInsets.trailing)
                    .opacity(self.isEnabled ? 1 : 0.8)
            }
        }
        .frame(height: 44)
    }
}

struct IOS6NavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        _IOS6NavigationBar()
    }
}
