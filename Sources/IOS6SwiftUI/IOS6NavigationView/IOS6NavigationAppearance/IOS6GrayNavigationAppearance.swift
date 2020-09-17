//
//  IOS6GrayNavigationAppearance.swift
//  Demo
//
//  Created by Xuan Li on 9/3/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

public struct IOS6GrayNavigationAppearance: IOS6NavigationAppearance {
    
    public init() {}
    
    public var contentBackground: some View {
        Color(red: 217/255, green: 218/255, blue: 223/255)
//            .clipShape(_DownRectangle(cornerRadius: 4, padding: 0))
            .ios6RootBackground(Color.black.edgesIgnoringSafeArea(.all))
            .ios6StatusBar(Color.black)
    }
    
    public var masterBackground: some View {
        LinearGradient(gradient: Gradient(colors: [Color(red: 233/255.0, green: 234/255.0, blue: 237/255.0),
                                                   Color(red: 190/255.0, green: 193/255.0, blue: 201/255.0)]),
                       startPoint: .top, endPoint: .bottom)
//            .clipShape(_DownRectangle(cornerRadius: 4, padding: 0))
            .ios6RootBackground(Color.black.edgesIgnoringSafeArea(.all))
            .ios6StatusBar(Color.black)
    }
    
    public var detailBackground: some View {
        LinearGradient(gradient: Gradient(colors: [Color(red: 227/255.0, green: 229/255.0, blue: 234/255.0),
                                                   Color(red: 206/255.0, green: 207/255.0, blue: 212/255.0)]),
                       startPoint: .top, endPoint: .bottom)
//            .clipShape(_DownRectangle(cornerRadius: 4, padding: 0))
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
                    Color.white
                        .frame(height: 0.5)
                    
                    Spacer()
                    
                    Color(red: 124/255.0, green: 128/255.0, blue: 140/255.0)
                        .frame(height: 1)
                }
        )
    }
    
    public var navigationBarBackground: some View {
        LinearGradient(
            gradient:
            Gradient(colors:
                [Color(red: 244/255.0, green: 245/255.0, blue: 246/255.0),
                 Color(red: 236/255.0, green: 237/255.0, blue: 240/255.0),
                 Color(red: 206/255.0, green: 208/255.0, blue: 214/255.0),
                 Color(red: 165/255.0, green: 168/255.0, blue: 182/255.0)]),
            startPoint: .top,
            endPoint: .bottom)
            .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 0.7)
            .overlay(
                VStack(spacing: 0) {
                    Color.white
                        .frame(height: 0.5)
                    
                    Spacer()
                    
                    Color(red: 124/255.0, green: 128/255.0, blue: 140/255.0)
                        .frame(height: 1)
                }
        ).clipShape(_UpRectangle(cornerRadius: 4))
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
                            [Color(red: 159.0/255.0, green: 162.0/255.0, blue: 163.0/255.0),
                             Color(red: 108.0/255.0, green: 111.0/255.0, blue: 113.0/255.0),
                             Color(red: 71.0/255.0, green: 75.0/255.0, blue: 81.0/255.0)]),
                        startPoint: .top, endPoint: .bottom) :
                    LinearGradient(
                        gradient: Gradient(colors:
                            [Color(red: 180.0/255.0, green: 182.0/255.0, blue: 187.0/255.0),
                             Color(red: 135.0/255.0, green: 140.0/255.0, blue: 147.0/255.0),
                             Color(red: 108.0/255.0, green: 114.0/255.0, blue: 123.0/255.0)]),
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
        IOS6GrayBarButtonStyle()
    }
    
    public func makeTextBody(content: Text) -> some View {
        content
            .foregroundColor(Color(red: 116/255.0, green: 123/255.0, blue: 129/255.0))
            .etched(isDown: false, color: Color(red: 230/255.0, green: 232/255.0, blue: 238/255.0))
    }
    
    public var accentColor: Color? {
        Color(red: 60.0/255.0, green: 82.0/255.0, blue: 130.0/255.0)
    }
}

extension IOS6GrayNavigationAppearance {
    struct IOS6GrayBarButtonStyle: ButtonStyle {
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
                                [Color(red: 159.0/255.0, green: 162.0/255.0, blue: 163.0/255.0),
                                 Color(red: 108.0/255.0, green: 111.0/255.0, blue: 113.0/255.0),
                                 Color(red: 71.0/255.0, green: 75.0/255.0, blue: 81.0/255.0)]),
                            startPoint: .top, endPoint: .bottom) :
                        LinearGradient(
                            gradient: Gradient(colors:
                                [Color(red: 180.0/255.0, green: 182.0/255.0, blue: 187.0/255.0),
                                 Color(red: 135.0/255.0, green: 140.0/255.0, blue: 147.0/255.0),
                                 Color(red: 108.0/255.0, green: 114.0/255.0, blue: 123.0/255.0)]),
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
}
