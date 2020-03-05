//
//  IOS6Section.swift
//  animation
//
//  Created by Xuan Li on 1/17/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

/// An affordance for creating hierarchical view content with IOS 6 style
public struct IOS6Section<Content: View>: View {
    let content: () -> Content
    let radius = CGFloat(8)
    
    public var body: some View {
        VStack(spacing: 0) {
            self.content()
        }
        .background(Color(red: 247.0/255.0, green: 247.0/255.0, blue: 247.0/255.0))
            .overlay( // Top shadow
                RoundedRectangle(cornerRadius: radius)
                    .stroke(Color(red: 80.0/255.0, green: 80.0/255.0, blue: 80.0/255.0), lineWidth: 0.5)
                    .blur(radius: 0.6)
                    .padding(EdgeInsets(top: 0.3, leading: -0.2, bottom: -0.5, trailing: -0.2))
        )
            .clipShape(RoundedRectangle(cornerRadius: radius))
            .overlay(   // Round frame
                RoundedRectangle(cornerRadius: radius)
                    .stroke(Color(red: 175.0/255.0, green: 178.0/255.0, blue: 184.0/255.0), lineWidth: 1)
        )
            .background(    // White bottom line
                GeometryReader { geo in
                    RoundedRectangle(cornerRadius: self.radius)
                        .stroke(Color.white.opacity(0.8), lineWidth: 1.2)
                        .frame(width: geo.size.width , alignment: .center)
                        .offset(x: 0, y: 0.6)
                }
        )
            .padding(11)
    }
    
    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
}

struct IOS6Section_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            IOS6Section {
                Text("Hello World")
            }
            
            IOS6NavigationView("Settings") {
                IOS6Form {
                    IOS6Section {
                        Text("Hello World")
                        IOS6Divider()
                        
                        Image("ins").resizable()
                            .cornerRadius(10)
                            .frame(width:200, height: 200)
                            .padding(10)
                        IOS6Divider()
                        
                        IOS6NavigationLink(destination: {Text("Hello World")}) {
                            Text("Tap Me").padding(10)
                        }
                    }
                }
            }
        }
    }
}
