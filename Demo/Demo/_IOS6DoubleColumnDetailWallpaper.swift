//
//  _IOS6DoubleColumnDetailWallpaper.swift
//  Demo
//
//  Created by Xuan Li on 9/1/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct _IOS6DoubleColumnDetailWallpaper: View {
    var body: some View {
        VStack(spacing: 0) {
            LinearGradient(
                gradient:
                Gradient(colors:
                    [Color(red: 244/255.0, green: 245/255.0, blue: 246/255.0),
                     Color(red: 236/255.0, green: 237/255.0, blue: 240/255.0),
                     Color(red: 206/255.0, green: 208/255.0, blue: 214/255.0),
                     Color(red: 165/255.0, green: 168/255.0, blue: 182/255.0)]),
                startPoint: .top,
                endPoint: .bottom
            )
                .shadow(color: Color.black.opacity(0.35), radius: 1, x: 0, y: 0.5)
                .overlay(
                    VStack(spacing: 0) {
                        Color.white
                            .frame(height: 0.5)
                        
                        Spacer()
                        
                        Color(red: 124/255.0, green: 128/255.0, blue: 142/255.0)
                            .frame(height: 1)
                    }
            )
                .frame(height: 44)
                .zIndex(1)
            
            LinearGradient(gradient: Gradient(colors: [Color(red: 227/255.0, green: 229/255.0, blue: 234/255.0),
                                                       Color(red: 206/255.0, green: 207/255.0, blue: 212/255.0)]),
                           startPoint: .top, endPoint: .bottom)
        }
        .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
        .edgesIgnoringSafeArea([.horizontal, .bottom])
    }
}

struct _IOS6DoubleColumnDetailWallpaper_Previews: PreviewProvider {
    static var previews: some View {
        _IOS6DoubleColumnDetailWallpaper()
    }
}
