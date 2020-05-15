//
//  IOS6ButtonStyle.swift
//  IOS6
//
//  Created by Xuan Li on 5/13/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

public struct IOS6ListButtonStyle: ButtonStyle {
    var at: IOS6SectionItemPosition
    var pressing: Bool
    var delay: Double
    
    init(at position: IOS6SectionItemPosition, is pressing: Bool) {
        at = position
        self.pressing = pressing
        delay = 0.15
    }
    
    public init(at position: IOS6SectionItemPosition) {
        at = position
        pressing = false
        delay = 0
    }
    
    public func makeBody(configuration: IOS6ListButtonStyle.Configuration) -> some View {
        MyButton(configuration: configuration, sectionPostion: at, pressing: pressing, delay: delay)
    }
    
    struct MyButton: View {
        var configuration: IOS6ListButtonStyle.Configuration
        var sectionPostion: IOS6SectionItemPosition
        var pressing: Bool
        var delay: Double
        @State var isPressed: Bool = false
        
        var body: some View {
            if isPressed != configuration.isPressed {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                    self.isPressed = self.configuration.isPressed
                }
            }
            let pressed = isPressed && configuration.isPressed || pressing
            return configuration.label
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .background(Color.white.opacity(0.01))
                .foregroundColor(pressed ? .white : .accentColor)
                .modifier(IOS6FormRowConfiguration(at: sectionPostion, background:
                    LinearGradient(
                        gradient: Gradient(colors:
                            [Color(red: 60.0/255.0, green: 140.0/255.0, blue: 237.0/255.0),
                             Color(red: 34.0/255.0, green: 98.0/255.0, blue: 224.0/255.0)]),
                        startPoint: .top, endPoint: .bottom)
                        .opacity(pressed ? 1 : 0)
                ))
        }
    }
    
}


struct IOS6ButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Button("Button") {}
            .buttonStyle(IOS6ListButtonStyle(at: .medium))
    }
}
