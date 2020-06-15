//
//  _IOS6NavigationWallpaper.swift
//  animation
//
//  Created by Xuan Li on 2/4/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct _IOS6NavigationWallpaper: View {
    
    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 0) {
                Color(red: 70/255, green: 100/255, blue: 133/255)
                    .frame(height: proxy.safeAreaInsets.top)
                
                Color(red: 211/255, green: 215/255, blue: 224/255)
                    .overlay(Strips().foregroundColor(Color(red: 208/255, green: 212/255, blue: 223/255)))
            }
            .compositingGroup()
            .cornerRadius(4)
            .background(Color.black)
        }
    }
    
    struct Strips: Shape {
        
        func path(in rect: CGRect) -> Path {
            var path = Path()
            
            let columnSize = CGFloat(9.375)
            let columns = Int(rect.width / columnSize)
            
            for column in 0..<columns {
                let startX = columnSize * CGFloat(column)
                let rect = CGRect(x: startX, y: 0, width: columnSize / 3, height: rect.height)
                path.addRect(rect)
            }
            
            return path
        }
    }
}

struct IOS6NavigationWallpaper_Previews: PreviewProvider {
    static var previews: some View {
        _IOS6NavigationWallpaper()
    }
}
