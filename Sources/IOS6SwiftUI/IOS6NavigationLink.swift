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
    let label: Label
    let destination: Destination
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
                self.label
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(Font.footnote.weight(.heavy))
                    .accentColor(Color(red: 120.0/255.0, green: 120.0/255.0, blue: 120.0/255.0))
                    .padding(.leading, 12)
                    .padding(.trailing, 2)
            }
        }
        .buttonStyle(IOS6ButtonStyle(at: sectionPostion, is: sheet))
        
    }
    
    public init(@ViewBuilder destination: () -> Destination, @ViewBuilder label: () -> Label, sectionPostion: IOS6SectionItemPosition = .medium) {
        self.destination = destination()
        self.label = label()
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
