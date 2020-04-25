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
    let sectionPostion: IOS6SectionItemPosition
    @State private var sheet = false
    
    public var body: some View {
        Button(action: {
            if viewStack != nil {
                self.sheet = true
                viewStack!.push(isPresent: self.$sheet,
                                title: self.title,
                                newView: self.destination())
            }
        }) {
            HStack(spacing: 0) {
                self.label()
                    .padding(.horizontal, 10)
                    .padding(.vertical, 9.5)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(Font.footnote.weight(.heavy))
                    .accentColor(Color(red: 120.0/255.0, green: 120.0/255.0, blue: 120.0/255.0))
                    .padding(.horizontal, 12)
            }
            .foregroundColor(sheet ? .white : .accentColor)
            .background(
                LinearGradient(
                    gradient: Gradient(colors:
                        [Color(red: 60.0/255.0, green: 140.0/255.0, blue: 237.0/255.0),
                         Color(red: 34.0/255.0, green: 98.0/255.0, blue: 224.0/255.0)]),
                    startPoint: .top, endPoint: .bottom)
                    .opacity(sheet ? 1 : 0)
            )
        }.ios6SecItem(at: sectionPostion)
    }
    
    public init(title: String = "", @ViewBuilder destination: @escaping () -> Destination, @ViewBuilder label: @escaping () -> Label, sectionPostion: IOS6SectionItemPosition = .medium) {
        self.destination = destination
        self.label = label
        self.title = title
        self.sectionPostion = sectionPostion
    }
}

struct IOS6NavigationLink_Previews: PreviewProvider {
    static var previews: some View {
        IOS6NavigationView("Settings") {
            IOS6Form {
                IOS6NavigationLink(destination: {Text("Hello World")}) {
                    Text("Tap Me")
                }
            }
        }
    }
}

