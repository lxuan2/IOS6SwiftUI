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
                        label
                            .environment(\._ios6IsSelected, label.id == configuration.selection.wrappedValue)
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
    
    struct NoButtonStyle: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
        }
    }
}
