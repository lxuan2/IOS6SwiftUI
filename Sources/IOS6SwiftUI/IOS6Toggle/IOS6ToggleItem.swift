//
//  IOS6ToggleItem.swift
//  animation
//
//  Created by Xuan Li on 3/1/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

/// A control that toggles between "on" and "off" states and label with IOS 6 style.
public struct IOS6ToggleItem: View {
    var image: Image? = nil
    var title: String = ""
    
    public var body: some View {
        HStack(spacing: 0) {
            if image != nil {
                image!.resizable()
                    .cornerRadius(5)
                    .overlay(   // Round frame
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.black.opacity(0.4), lineWidth: 0.5)
                )
                    .scaledToFit()
            }
            
            Spacer().frame(width: image != nil ? 12: 6)
            
            Text(title)
                .fontWeight(Font.Weight.bold)
                .accentColor(.black)
        }
        .frame(height: 30)
    }
    public init(image: Image? = nil, title: String = "") {
        self.image = image
        self.title = title
    }
}

struct IOS6ToggleItem_Previews: PreviewProvider {
    static var previews: some View {
        IOS6ToggleItem(image: Image("ins"), title: "Toggle")
    }
}
