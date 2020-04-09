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
    let radius: CGFloat = 9
    
    public var body: some View {
        VStack(spacing: 0) {
            self.content()
            Spacer().frame(height: 1.6)
        }
        .background(Color(red: 247.0/255.0, green: 247.0/255.0, blue: 247.0/255.0))
        .overlay(
            RoundedRectangle(cornerRadius: radius)
                .stroke(Color(red: 150.0/255.0, green: 150.0/255.0, blue: 150.0/255.0), lineWidth: 0.8)
                .blur(radius: 1)
                .padding(EdgeInsets(top: 0.5, leading: -0.2, bottom: -0.5, trailing: -0.2))
        )
            .cornerRadius(radius)
            .overlay(
                RoundedRectangle(cornerRadius: self.radius)
                    .strokeBorder(Color(red: 170.0/255.0, green: 172.0/255.0, blue: 176.0/255.0), lineWidth: 1.1)
                    .padding(.bottom, 1.6)
        )
            .padding(10)
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
