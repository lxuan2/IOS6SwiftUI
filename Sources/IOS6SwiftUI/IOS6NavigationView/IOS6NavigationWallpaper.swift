//
//  IOS6NavigationWallpaper.swift
//  animation
//
//  Created by Xuan Li on 2/4/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct IOS6NavigationWallpaper: View {
    @Environment(\.verticalSizeClass) var sizeClass
    
    var body: some View {
        VStack(spacing: 0) {
            Color(red: 70/255, green: 94/255, blue: 125/255)
                .frame(height: statusBarHeight)
            Color(red: 214/255, green: 217/255, blue: 225/255)
                .overlay(Strips().foregroundColor(Color(red: 210/255, green: 214/255, blue: 224/255)))
        }
        .cornerRadius(4)
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
    }
    
    var statusBarHeight: CGFloat {
        if let top = UIApplication.shared.windows.first(where: {$0.isKeyWindow })?.safeAreaInsets.top {
            return top + 3
        } else {
            return 0.0
        }
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return true
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
        IOS6NavigationWallpaper()
    }
}
