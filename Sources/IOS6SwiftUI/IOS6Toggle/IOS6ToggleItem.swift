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
    @Binding var isOn: Bool
    var image: Image? = nil
    var title: String = ""
    var color: Color = Color(red: 0/255.0, green: 127/255.0, blue: 234/255.0)
    //Color(red: 255.0/255.0, green: 127.0/255.0, blue: 2.0/255.0) orange
    
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
            
            Spacer()
            
            IOS6Toggle(isOn: $isOn, toggleColor: color)
                .padding(.trailing, 11)
        }
        .frame(height: 30)
        .IOS6NavigationItemPadding()
        .overlay(IOS6Divider(), alignment: .bottom)
    }
    public init(isOn: Binding<Bool>, image: Image? = nil, title: String = "", color: Color = Color(red: 0/255.0, green: 127/255.0, blue: 234/255.0)) {
        _isOn = isOn
        self.image = image
        self.title = title
        self.color = color
    }
}

struct IOS6ToggleItem_Previews: PreviewProvider {
    static var previews: some View {
        IOS6ToggleItem(isOn: .constant(false), image: Image("ins"), title: "Toggle")
    }
}
