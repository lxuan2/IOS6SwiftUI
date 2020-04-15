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
    let title: String
    let label: () -> Label
    let destination: () -> Destination
    @State private var sheet = false
    @State private var pressed = false
    @State private var beforePressed = false
    
    public var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors:
                    [Color(red: 60.0/255.0, green: 140.0/255.0, blue: 237.0/255.0),
                     Color(red: 34.0/255.0, green: 98.0/255.0, blue: 224.0/255.0)]),
                startPoint: .top, endPoint: .bottom)
            Color(red: 247.0/255.0, green: 247.0/255.0, blue: 247.0/255.0).opacity(pressed || sheet ? 0 : 1)
            HStack(spacing: 0) {
                self.label()
                    .IOS6NavigationItemPadding()
                
                Image(systemName: "chevron.right")
                    .font(Font.footnote.weight(.heavy))
                    .accentColor(Color(red: 120.0/255.0, green: 120.0/255.0, blue: 120.0/255.0))
                    .padding(12)
            }
            .foregroundColor(pressed || sheet ? .white : .accentColor)
        }
        .overlay(IOS6Divider(), alignment: .bottom)
        .onTapGesture {
            if viewStack != nil {
                self.sheet = true
                viewStack!.push(isPresent: self.$sheet,
                                    title: self.title,
                                    newView: self.destination())
            }
        }
        .onLongPressGesture(minimumDuration: .infinity, maximumDistance: 5, pressing: pressingHandler, perform: {})
    }
    
    public init(title: String = "", @ViewBuilder destination: @escaping () -> Destination, @ViewBuilder label: @escaping () -> Label) {
        self.destination = destination
        self.label = label
        self.title = title
    }
    
    func pressingHandler(pressing: Bool) {
        self.beforePressed = pressing
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.pressed = self.beforePressed
        }
    }
}

struct IOS6NavigationLink_Previews: PreviewProvider {
    static var previews: some View {
        IOS6NavigationView("Settings") {
            IOS6Form {
                IOS6Section {
                    IOS6NavigationLink(destination: {Text("Hello World")}) {
                        Text("Tap Me")
                    }
                }
            }
        }
    }
}
