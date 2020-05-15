//
//  IOS6ButtonStyle.swift
//  IOS6
//
//  Created by Xuan Li on 5/13/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

public struct IOS6ButtonStyle: ButtonStyle {
    var at: IOS6SectionItemPosition
    var pressing: Bool
    
    init(at position: IOS6SectionItemPosition, is pressing: Bool) {
        at = position
        self.pressing = pressing
    }
    
    public init(at position: IOS6SectionItemPosition) {
        at = position
        pressing = false
    }
    
    public func makeBody(configuration: IOS6ButtonStyle.Configuration) -> some View {
        MyButton(configuration: configuration, sectionPostion: at, pressing: pressing)
    }
    
    struct MyButton: View {
        var configuration: IOS6ButtonStyle.Configuration
        var sectionPostion: IOS6SectionItemPosition
        var pressing: Bool
        @State var isPressed: Bool = false
        
        var body: some View {
            if isPressed != configuration.isPressed {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                    self.isPressed = self.configuration.isPressed
                }
            }
            let pressed = isPressed && configuration.isPressed || pressing
            let frame: CGFloat? = sectionPostion == .none ? .none : .infinity
            let alignment: Alignment = sectionPostion == .none ? .center : .leading
            return configuration.label
                .frame(maxWidth: frame, maxHeight: frame, alignment: alignment)
                .contentShape(Rectangle())
                .background(ZStack {
                    Spacer()
                    if pressed && sectionPostion == .none {
                        LinearGradient(
                            gradient: Gradient(colors:
                                [Color(red: 60.0/255.0, green: 140.0/255.0, blue: 237.0/255.0),
                                 Color(red: 34.0/255.0, green: 98.0/255.0, blue: 224.0/255.0)]),
                            startPoint: .top, endPoint: .bottom)
                    }
                })
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
            .buttonStyle(IOS6ButtonStyle(at: .medium))
    }
}
