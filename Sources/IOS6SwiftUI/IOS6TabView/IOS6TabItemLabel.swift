//
//  IOS6TabItemLabel.swift
//  IOS6
//
//  Created by Xuan Li on 6/21/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

public struct IOS6TabItemLabel: View {
    @Environment(\.ios6IsSelected) var isSelected
    let image: Image
    let text: String
    let padding: CGFloat
    
    public var body: some View {
        ZStack {
            Color.white.opacity(isSelected ? 0.15 : 0).cornerRadius(3)
            
            VStack(spacing: 0) {
                Group {
                    if isSelected {
                        _IOS6TabItemLabelWallpaper()
                    } else {
                        LinearGradient(gradient: Gradient(colors: [Color(red: 160/255.0, green: 160/255.0, blue: 160/255.0), Color(red: 90/255.0, green: 90/255.0, blue: 90/255.0)]), startPoint: .top, endPoint: .bottom)
                    }
                }
                .aspectRatio(1.5, contentMode: .fit)
                .mask(image.resizable().padding(padding).scaledToFit())
                .shadow(color: .black, radius: 1, x: 0, y: isSelected ? 1.5 : -1.5)
                .padding(3)
                
                Text(text).font(.system(size: 10)).fontWeight(.bold)
                    .foregroundColor(isSelected ? .white : .gray)
            }
        }
        .contentShape(Rectangle())
        .padding(.top, 1)
        .padding(2)
    }
    
    public init(image: Image, text: String, padding: CGFloat = 0) {
        self.image = image
        self.text = text
        self.padding = padding
    }
}

struct IOS6TabItemLabel_Previews: PreviewProvider {
    static var previews: some View {
        IOS6TabItemLabel(image: Image(systemName: "mic"), text: "Mic")
    }
}
