//
//  IOS6ListButtonStyle.swift
//  IOS6
//
//  Created by Xuan Li on 7/18/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

public struct IOS6ListButtonStyle: PrimitiveButtonStyle {
    
    public init() {}
    public func makeBody(configuration: IOS6ListButtonStyle.Configuration) -> some View {
        _IOS6ButtonStyleButton(configuration: configuration)
    }
    
    private struct _IOS6ButtonStyleButton: View {
        let configuration: IOS6ListButtonStyle.Configuration
        @State private var isPressed: Bool = false
        
        var body: some View {
            Button(action: {
                self.isPressed = true
                withAnimation {
                    self.isPressed = false
                }
                self.configuration.trigger()
            }) {
                configuration.label
            }
            .buttonStyle(IOS6ListBaseButtonStyle())
            .environment(\.ios6ButtonSelected, isPressed)
        }
    }
}


public struct IOS6ListBaseButtonStyle: ButtonStyle {
    
    public init() {}
    public func makeBody(configuration: IOS6ListBaseButtonStyle.Configuration) -> some View {
        _IOS6ButtonStyleButton(configuration: configuration)
    }
    
    private struct _IOS6ButtonStyleButton: View {
        let configuration: IOS6ListBaseButtonStyle.Configuration
        @State private var isPressed: Bool = false
        @State private var hold: Bool = false
        @State private var isLink: Bool = false
        @Environment(\.ios6ButtonSelected) private var isSelected
        @Environment(\.isEnabled) private var isEnabled
        
        var body: some View {
            if isPressed != configuration.isPressed {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    self.isPressed = self.configuration.isPressed
                }
            }
            let pressed = isSelected || hold || isPressed && configuration.isPressed
            return
                HStack {
                    configuration.label
                        .environment(\.ios6ButtonSelected, pressed)
                        .onPreferenceChange(_IOS6NavigationisLinkPreferenceKey.self) { value in
                            self.isLink = value
                    }
                    .onPreferenceChange(_IOS6HoldPressPreferenceKey.self) { value in
                        withAnimation(self.hold && !value ? Animation.spring().delay(0.35) : .none) {
                            self.hold = value
                        }
                    }
                    
                    if isLink {
                        Spacer(minLength: 23)
                    }
                }
                .opacity(self.isEnabled ? 1 : 0.9)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .contentShape(Rectangle())
                .listRowBackground(
                    ZStack(alignment: .trailing) {
                        VStack(spacing: 0) {
                            Color.white
                                .blendMode(.destinationOver)
                                .frame(minHeight: 1, maxHeight: 1)
                            
                            Spacer()
                            
                            Color.black.opacity(0.11)
                                .frame(minHeight: 1, maxHeight: 1)
                        }
                        
                        IOS6ButtonDefaultListBackground
                            .opacity(pressed ? 1 : 0)
                        
                        if isLink {
                            Image(systemName: "chevron.right")
                                .font(Font.footnote.weight(.heavy))
                                .foregroundColor(.white)
                                .colorMultiply(pressed ? .white : Color(red: 120.0/255.0, green: 120.0/255.0, blue: 120.0/255.0))
                                .padding(.horizontal, 14.5)
                        }
                    }
            )
                    //.listRowInsets(.init(top: 8.5, leading: 15, bottom: 9.5, trailing: 15))
                    .listRowInsets(EdgeInsets(top: 6.5, leading: 15, bottom: 7.5, trailing: 11))
        }
        
        var IOS6ButtonDefaultListBackground: LinearGradient {
            LinearGradient(
                gradient: Gradient(colors:
                    [Color(red: 4.0/255.0, green: 140.0/255.0, blue: 245.0/255.0),
                     Color(red: 0.0/255.0, green: 94.0/255.0, blue: 230.0/255.0)]),
                startPoint: .top, endPoint: .bottom)
        }
    }
}
