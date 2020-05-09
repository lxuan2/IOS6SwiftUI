//
//  IOS6NavigationLink.swift
//  animation
//
//  Created by Xuan Li on 1/22/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI
import Foundation

/// A view that controls a navigation presentation with IOS 6 style.
public struct IOS6NavigationLink<Label: View, Destination : View>: View {
    let label: () -> Label
    let destination: () -> Destination
    let sectionPostion: IOS6SectionItemPosition
    @State private var sheet = false
    
    public var body: some View {
        Button(action: {
            if viewStack != nil {
                self.sheet = true
                viewStack!.push(isPresent: self.$sheet,
                                newView: self.destination)
            }
        }) {
            HStack(spacing: 0) {
                self.label()
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(Font.footnote.weight(.heavy))
                    .accentColor(Color(red: 120.0/255.0, green: 120.0/255.0, blue: 120.0/255.0))
                    .padding(.leading, 12)
                    .padding(.trailing, 2)
            }
        }
        .buttonStyle(MyButtonStyle(at: sectionPostion, pressing: sheet))
        
    }
    
    public init(@ViewBuilder destination: @escaping () -> Destination, @ViewBuilder label: @escaping () -> Label, sectionPostion: IOS6SectionItemPosition = .medium) {
        self.destination = destination
        self.label = label
        self.sectionPostion = sectionPostion
    }
}

struct IOS6NavigationLink_Previews: PreviewProvider {
    static var previews: some View {
        IOS6NavigationView {
            IOS6Form {
                IOS6NavigationLink(destination: {Text("Hello World")}) {
                    Text("Tap Me")
                }
            }
        }
    }
}

struct MyButtonStyle: ButtonStyle {
    var at: IOS6SectionItemPosition
    var pressing: Bool
    
    public func makeBody(configuration: MyButtonStyle.Configuration) -> some View {
        MyButton(configuration: configuration, sectionPostion: at, pressing: pressing)
    }
    
    struct MyButton: View {
        var configuration: MyButtonStyle.Configuration
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
            return configuration.label
                .background(Color.white.opacity(0.01))
                .foregroundColor(pressed ? .white : .accentColor)
                .modifier(IOS6FormSectionItem(at: sectionPostion, background:
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
