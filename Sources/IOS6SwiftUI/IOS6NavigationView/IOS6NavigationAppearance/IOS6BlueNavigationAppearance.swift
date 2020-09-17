//
//  IOS6BlueNavigationAppearance.swift
//  Demo
//
//  Created by Xuan Li on 9/3/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

public struct IOS6BlueNavigationAppearance: IOS6NavigationAppearance {
    
    public init() {}
    
    public var contentBackground: some View {
        Color(red: 211/255, green: 215/255, blue: 224/255)
            .overlay(Strips().foregroundColor(Color(red: 208/255, green: 212/255, blue: 223/255)))
            .ios6StatusBar(Color(red: 70/255, green: 100/255, blue: 133/255))
    }
    
    public var masterBackground: some View {
        Color(red: 220/255, green: 225/255, blue: 236/255)
    }
    
    public var detailBackground: some View {
        Color(red: 220/255, green: 225/255, blue: 236/255)
    }
    
    public var toolBarBackground: some View {
        LinearGradient(
            gradient:
            Gradient(colors:
                [Color(red: 174.0/255.0, green: 189.0/255.0, blue: 208.0/255.0),
                 Color(red: 136.0/255.0, green: 153.0/255.0, blue: 178.0/255.0),
                 Color(red: 92.0/255.0, green: 113.0/255.0, blue: 148.0/255.0)]),
            startPoint: .top,
            endPoint: .bottom
        )
            .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: -0.7)
            .overlay(
                VStack(spacing: 0) {
                    Color(red: 233/255.0, green: 244/255.0, blue: 255/255.0)
                        .frame(height: 0.5)
                    
                    Spacer()
                    
                    Color(red: 69/255.0, green: 91/255.0, blue: 125/255.0)
                        .frame(height: 1)
                }
        )
    }
    
    public var navigationBarBackground: some View {
        LinearGradient(
            gradient:
            Gradient(colors:
                [Color(red: 90.0/255.0, green: 116.0/255.0, blue: 153.0/255.0),
                 Color(red: 143.0/255.0, green: 163.0/255.0, blue: 188.0/255.0),
                 Color(red: 190.0/255.0, green: 203.0/255.0, blue: 220.0/255.0)]),
            startPoint: .bottom,
            endPoint: .top
        )
            .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 0.7)
            .overlay(
                VStack(spacing: 0) {
                    Color(red: 233/255.0, green: 244/255.0, blue: 255/255.0)
                        .frame(height: 0.5)
                    
                    Spacer()
                    
                    Color(red: 69/255.0, green: 91/255.0, blue: 125/255.0)
                        .frame(height: 1)
                }
        )
    }
    
    public func makeNavigationBarBackButtonBody(configuration: IOS6NavigationBarBackButtonConfiguration) -> some View {
        ZStack {
            _IOS6NavigationBackButtonShape()
                .fill(Color.white)
                .offset(x: 0, y: 0.5)
                .blur(radius: 0.4)
            
            _IOS6NavigationBackButtonShape()
                .fill(configuration.isPressed ?
                    LinearGradient(
                        gradient: Gradient(colors:
                            [Color(red: 150.0/255.0, green: 160.0/255.0, blue: 180.0/255.0),
                             Color(red: 93.0/255.0, green: 109.0/255.0, blue: 140.0/255.0),
                             Color(red: 53.0/255.0, green: 72.0/255.0, blue: 115.0/255.0)]),
                        startPoint: .top, endPoint: .bottom) :
                    LinearGradient(
                        gradient: Gradient(colors:
                            [Color(red: 150.0/255.0, green: 166.0/255.0, blue: 188.0/255.0),
                             Color(red: 102.0/255.0, green: 123.0/255.0, blue: 155.0/255.0),
                             Color(red: 71.0/255.0, green: 98.0/255.0, blue: 138.0/255.0)]),
                        startPoint: .top, endPoint: .bottom)
            )
                .overlay(
                    _IOS6NavigationBackButtonShape()
                        .stroke(Color(red: 51.0/255.0, green: 72.0/255.0, blue: 105.0/255.0), lineWidth: 1))
                .overlay(
                    _IOS6NavigationBackButtonShape()
                        .stroke(Color(red: 30/255.0, green: 40/255.0, blue: 50/255.0), lineWidth: 1)
                        .blur(radius: 0.4)
                        .offset(x: 0, y: 0.4))
                .clipShape(_IOS6NavigationBackButtonShape())
            
            configuration.label
                .foregroundColor(.white)
                .scaledFont(size: 11.5, weight: .bold)
                .etched()
                .padding(.leading, 25 / 2)
                .padding([.vertical, .trailing], 25 / 2.9)
                .layoutPriority(1)
                .frame(minWidth: 30)
        }.compositingGroup()
    }
    
    public var barButtonStyle: some ButtonStyle {
        IOS6BlueBarButtonStyle()
    }
    
    public func makeTextBody(content: Text) -> some View {
        content
            .foregroundColor(.white)
            .etched()
    }
    
    public var accentColor: Color? {
        Color(red: 60.0/255.0, green: 82.0/255.0, blue: 130.0/255.0)
    }
}

extension IOS6BlueNavigationAppearance {
    struct IOS6BlueBarButtonStyle: ButtonStyle {
        let height: CGFloat = 25
        
        func makeBody(configuration: Configuration) -> some View {
            ZStack {
                _IOS6NavigationBackButtonShape()
                    .fill(Color.white)
                    .offset(x: 0, y: 0.5)
                    .blur(radius: 0.4)
                
                _IOS6NavigationBackButtonShape()
                    .fill(configuration.isPressed ?
                        LinearGradient(
                            gradient: Gradient(colors:
                                [Color(red: 150.0/255.0, green: 160.0/255.0, blue: 180.0/255.0),
                                 Color(red: 93.0/255.0, green: 109.0/255.0, blue: 140.0/255.0),
                                 Color(red: 53.0/255.0, green: 72.0/255.0, blue: 115.0/255.0)]),
                            startPoint: .top, endPoint: .bottom) :
                        LinearGradient(
                            gradient: Gradient(colors:
                                [Color(red: 150.0/255.0, green: 166.0/255.0, blue: 188.0/255.0),
                                 Color(red: 102.0/255.0, green: 123.0/255.0, blue: 155.0/255.0),
                                 Color(red: 71.0/255.0, green: 98.0/255.0, blue: 138.0/255.0)]),
                            startPoint: .top, endPoint: .bottom)
                )
                    .overlay(
                        _IOS6NavigationBackButtonShape()
                            .stroke(Color(red: 51.0/255.0, green: 72.0/255.0, blue: 105.0/255.0), lineWidth: 1))
                    .overlay(
                        _IOS6NavigationBackButtonShape()
                            .stroke(Color(red: 30/255.0, green: 40/255.0, blue: 50/255.0), lineWidth: 1)
                            .blur(radius: 0.4)
                            .offset(x: 0, y: 0.4))
                    .clipShape(_IOS6NavigationBackButtonShape())
                
                configuration.label
                    .foregroundColor(.white)
                    .scaledFont(size: 11.5, weight: .bold)
                    .etched()
                    .padding(25 / 2.9)
                    .layoutPriority(1)
                    .frame(minWidth: 30)
            }.compositingGroup()
        }
    }
    
    struct Strips: Shape {
        
        func path(in rect: CGRect) -> Path {
            var path = Path()
            
            let columnSize = CGFloat(9.375)
            let columns = Int(rect.width / columnSize)
            
            for column in 0..<columns {
                let startX = columnSize * CGFloat(column)
                let rect = CGRect(x: startX, y: 0, width: columnSize / 3, height: rect.height)
                path.addRect(rect)
            }
            
            return path
        }
    }
}
