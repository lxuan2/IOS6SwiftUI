//
//  IOS6ButtonStyle.swift
//  IOS6
//
//  Created by Xuan Li on 5/13/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

public struct IOS6ButtonStyle<Background: View>: ButtonStyle {
    let at: IOS6SectionItemPosition
    let pressing: Bool
    let background: Background
    
    init(at position: IOS6SectionItemPosition, is pressing: Bool, background bg: Background) {
        at = position
        self.pressing = pressing
        background = bg
    }
    
    public init(at position: IOS6SectionItemPosition = .none, background bg: Background) {
        at = position
        pressing = false
        background = bg
    }
    
    public func makeBody(configuration: IOS6ButtonStyle.Configuration) -> some View {
        IOS6ButtonStyleButton(configuration: configuration, sectionPostion: at, pressing: pressing, background: background)
    }
    
    struct IOS6ButtonStyleButton<Background: View>: View {
        let configuration: IOS6ButtonStyle.Configuration
        let sectionPostion: IOS6SectionItemPosition
        let pressing: Bool
        let background: Background
        @State private var isPressed: Bool = false
        
        var body: some View {
            if isPressed != configuration.isPressed {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    self.isPressed = self.configuration.isPressed
                }
            }
            return configuration.label
                .frame(maxWidth: frame, maxHeight: frame, alignment: alignment)
                .contentShape(Rectangle())
                .accentColor(pressed ? .white : nil)
                .ios6ActiveColor(pressed ? .white : nil)
                .background(backgroundView)
                .modifier(IOS6FormRowConfiguration(at: sectionPostion, background: background.opacity(pressed ? 1 : 0)))
        }
        
        var frame: CGFloat? {
            sectionPostion == .none ? .none : .infinity
        }
        
        var alignment: Alignment {
            sectionPostion == .none ? .center : .leading
        }
        
        var pressed: Bool {
            isPressed && configuration.isPressed || pressing
        }
        
        var backgroundView: some View {
            ZStack {
                EmptyView()
                if pressed && sectionPostion == .none {
                    background
                }
            }
        }
    }
}

var IOS6ButtonDefaultBackground: LinearGradient {
    LinearGradient(
        gradient: Gradient(colors:
            [Color(red: 60.0/255.0, green: 140.0/255.0, blue: 237.0/255.0),
             Color(red: 34.0/255.0, green: 98.0/255.0, blue: 224.0/255.0)]),
        startPoint: .top, endPoint: .bottom)
}

struct IOS6ButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Button("Button") {}
            .buttonStyle(IOS6ButtonStyle(at: .medium, background: IOS6ButtonDefaultBackground))
    }
}
