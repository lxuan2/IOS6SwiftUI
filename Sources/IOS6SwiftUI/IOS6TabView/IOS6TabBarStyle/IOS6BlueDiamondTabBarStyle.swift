//
//  IOS6BlueDiamondTabBarStyle.swift
//  IOS6
//
//  Created by Xuan Li on 7/15/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

public struct IOS6BlueDiamondTabBarStyle: IOS6TabBarStyle {
    private let height: CGFloat = 50
    
    public func makeBody(configuration: Configuration) -> some View {
        ZStack {
            Color.black
                .overlay(topLayer, alignment: .top)
                .overlay(Rectangle().fill(Color.white.opacity(0.18)).frame(height: 0.5).padding(.top, 1), alignment: .top)
                .edgesIgnoringSafeArea(.all)
                .zIndex(0)
            
            HStack(spacing: 0) {
                ForEach(configuration.labels) { label in
                    Button(action: {
                        configuration.selection.wrappedValue = label.id
                    }) {
                        TabItem(isSelected: label.id == configuration.selection.wrappedValue, label: label)
                    }.buttonStyle(NoButtonStyle())
                }
            }
        }.frame(height: height).colorScheme(.light)
    }
    
    private var topLayer: some View {
        LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.2), Color.white.opacity(0.1)]), startPoint: .top, endPoint: .bottom)
            .frame(height: height / 2)
            .padding(.top, 1)
    }
    
    private struct NoButtonStyle: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
        }
    }
    
    private struct TabItem: View {
        let isSelected: Bool
        let label: IOS6TabBarStyleConfiguration.Label
        
        var body: some View {
            ZStack {
                Color.white.opacity(isSelected ? 0.15 : 0).cornerRadius(3)
                
                VStack(spacing: 0) {
                    Group {
                        if isSelected {
                            _IOS6BlueDiamondTabBarWallpaper()
                        } else {
                            LinearGradient(gradient: Gradient(colors: [Color(red: 160/255.0, green: 160/255.0, blue: 160/255.0), Color(red: 90/255.0, green: 90/255.0, blue: 90/255.0)]), startPoint: .top, endPoint: .bottom)
                        }
                    }
                    .aspectRatio(1.5, contentMode: .fit)
                    .mask(label.icon.scaledToFit())
                    .shadow(color: .black, radius: 1, x: 0, y: isSelected ? 1 : -1)
                    .padding(3)
                    
                    label.title
                        .scaledFont(size: 10, weight: .bold)
                        .foregroundColor(isSelected ? .white : .gray)
                }
            }
            .contentShape(Rectangle())
            .padding(.top, 1)
            .padding(2)
        }
    }
    
    struct _IOS6BlueDiamondTabBarWallpaper: View {
        var body: some View {
            LinearGradient(gradient: Gradient(colors: [Color(red: 25/255.0, green: 108/255.0, blue: 238/255.0),
                                                       Color(red: 35/255.0, green: 135/255.0, blue: 211/255.0),
                                                       Color(red: 36/255.0, green: 139/255.0, blue: 220/255.0),
                                                       Color(red: 48/255.0, green: 180/255.0, blue: 231/255.0),
                                                       Color(red: 66/255.0, green: 207/255.0, blue: 247/255.0)]),
                           startPoint: .top, endPoint: .bottom)
            .overlay(
                LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.8),
                                            Color.white.opacity(0.6),
                                            Color.white.opacity(0.3),
                                            Color.white.opacity(0.0)]),
                    startPoint: .top, endPoint: .bottom).clipShape(_CuttingCircle())
            )
        }
        
        struct _CuttingCircle: Shape {
            func path(in rect: CGRect) -> Path {
                var path = Path()
                
                path.move(to: CGPoint(x: 0, y: 0))
                path.addLine(to: CGPoint(x: 0, y: rect.height * 4/5))
                path.addQuadCurve(to: CGPoint(x: rect.width, y: rect.height * 2/5), control: CGPoint(x: rect.width * 1/2, y: rect.height * 2.5/5))
                path.addLine(to: CGPoint(x: rect.width, y: 0))
                path.closeSubpath()
                
                return path
            }
        }
    }
}
