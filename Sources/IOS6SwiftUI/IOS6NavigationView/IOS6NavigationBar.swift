//
//  IOS6NavigationBar.swift
//  animation
//
//  Created by Xuan Li on 2/4/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct IOS6NavigationBar: View {
    let navigationBarHeight: CGFloat
    
    var body: some View {
        Rectangle()
            .frame(maxWidth: .infinity, maxHeight: navigationBarHeight)
            .foregroundColor(Color(red: 68.0/255.0, green: 90.0/255.0, blue: 140.0/255.0))
            .overlay(
                LinearGradient(
                    gradient:
                    Gradient(colors:
                        [Color(red: 89.0/255.0, green: 115.0/255.0, blue: 152.0/255.0),
                         Color(red: 135.0/255.0, green: 156.0/255.0, blue: 183.0/255.0),
                         Color(red: 195.0/255.0, green: 205.0/255.0, blue: 220.0/255.0)]),
                    startPoint: .bottom,
                    endPoint: .top
                )
        )
            .overlay(
                Rectangle()
                    .foregroundColor(Color(red: 233/255, green: 244/255, blue: 255/255))
                    .frame(maxWidth: .infinity, maxHeight: 0.55)
                ,
                alignment: .top)
            .overlay(
                Rectangle()
                    .foregroundColor(Color(red: 69/255, green: 91/255, blue: 125/255))
                    .frame(maxWidth: .infinity, maxHeight: 1.1)
                ,
                alignment: .bottom)
            .shadow(color: Color.gray.opacity(0.5), radius: 1, x: 0, y: 0.7)
            .edgesIgnoringSafeArea([.horizontal])
            .overlay(IOS6NavigationBarItems(navigationBarHeight: navigationBarHeight))
    }
}

struct IOS6NavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        IOS6NavigationBar(navigationBarHeight: 45)
    }
}
