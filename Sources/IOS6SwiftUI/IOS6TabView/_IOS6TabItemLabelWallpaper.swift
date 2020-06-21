//
//  _IOS6TabItemLabelWallpaper.swift
//  IOS6
//
//  Created by Xuan Li on 6/21/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct _IOS6TabItemLabelWallpaper: View {
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Color(red: 25/255.0, green: 108/255.0, blue: 238/255.0),
                                                   Color(red: 25/255.0, green: 108/255.0, blue: 238/255.0),
                                                   Color(red: 25/255.0, green: 108/255.0, blue: 238/255.0),
                                                   Color(red: 53/255.0, green: 178/255.0, blue: 247/255.0),
                                                   Color(red: 68/255.0, green: 214/255.0, blue: 252/255.0)]),
                       startPoint: .top, endPoint: .bottom)
        .overlay(
            LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.9),
                                        Color.white.opacity(0.6),
                                        Color.white.opacity(0.3),
                                        Color.white.opacity(0.0)]),
                startPoint: .top, endPoint: .bottom).clipShape(_CuttingCircle())
            
        )
    }
    
    struct _CuttingCircle: Shape {
        func path(in rect: CGRect) -> Path {
            var path = Path()
            
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: 0, y: rect.height * 4/5))
            path.addQuadCurve(to: CGPoint(x: rect.width, y: rect.height * 2/5), control: CGPoint(x: rect.width * 1/2, y: rect.height * 2.5/5))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.closeSubpath()
            
            return path
        }
    }
}



struct IOS6TabItemLabelWallpaper_Previews: PreviewProvider {
    static var previews: some View {
        _IOS6TabItemLabelWallpaper()
    }
}