//
//  IOS6BlueSliderStyle.swift
//  Demo
//
//  Created by Xuan Li on 8/18/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

public struct IOS6BlueSliderStyle: IOS6SliderStyle {
    public func makeBody(configuration: Configuration) -> some View {
        IOS6BlueSliderStyleSlider(configuration: configuration)
    }
    
    private struct IOS6BlueSliderStyleSlider: View {
        @State private var isPressed: Bool = false
        @State private var dragAmount: CGFloat = 0
        let configuration: Configuration
        let circleHeight: CGFloat = 21
        let barHeight: CGFloat = 9
        
        var body: some View {
            GeometryReader { proxy in
                ZStack {
                    HStack(spacing: 0) {
                        LinearGradient(gradient: Gradient(colors:
                            [Color(red: 48/255.0, green: 100/255.0, blue: 184/255.0),
                             Color(red: 61/255.0, green: 115/255.0, blue: 197/255.0),
                             Color(red: 87/255.0, green: 138/255.0, blue: 216/255.0),
                             Color(red: 108/255.0, green: 161/255.0, blue: 237/255.0),
                             Color(red: 118/255.0, green: 174/255.0, blue: 246/255.0)]),
                                       startPoint: .top, endPoint: .bottom)
                            .frame(width: self.clippedValue * proxy.size.width)
                        
                        LinearGradient(gradient: Gradient(colors:
                            [Color.black.opacity(0.3),
                             Color.black.opacity(0.24),
                             Color.black.opacity(0.12),
                             Color.black.opacity(0),
                             Color.black.opacity(0)]),
                                       startPoint: .top, endPoint: .bottom)
                    }
                    .overlay(
                        Capsule()
                            .strokeBorder(Color.black.opacity(0.3), lineWidth: proxy.size.height / 36)
                    )
                        .background(Color.white)
                        .clipShape(Capsule())
                        .frame(height: self.barHeight)
                    
                    Circle()
                        .fill(
                            LinearGradient(gradient: Gradient(colors:
                                [self.isPressed ? Color(red: 200/255.0, green: 200/255.0, blue: 200/255.0) :
                                    Color(red: 210/255.0, green: 210/255.0, blue: 210/255.0),
                                 self.isPressed ? Color(red: 215/255.0, green: 215/255.0, blue: 215/255.0) :
                                    Color(red: 230/255.0, green: 230/255.0, blue: 230/255.0),
                                 self.isPressed ? Color(red: 230/255.0, green: 230/255.0, blue: 230/255.0) :
                                    Color(red: 255/255.0, green: 255/255.0, blue: 255/255.0)]),
                                           startPoint: .top, endPoint: .bottom)
                    )
                        .gesture(
                            DragGesture(minimumDistance: 14, coordinateSpace: .named("IOS6Slider"))
                                .onChanged { value in
                                    self.configuration.value = max(min(self.configuration.value + (value.translation.width - self.dragAmount)/(proxy.size.width-self.circleHeight), 1), 0)
                                    self.dragAmount = value.translation.width
                            }
                            .onEnded { value in
                                self.configuration.value = max(min(self.configuration.value + (value.translation.width - self.dragAmount)/(proxy.size.width-self.circleHeight), 1), 0)
                                self.dragAmount = 0
                            }
                    )
                        .onLongPressGesture(minimumDuration: .infinity, maximumDistance: .infinity, pressing: { value in self.isPressed = value }, perform: {})
                        .contentShape(Circle())
                        .background(Circle().strokeBorder(Color.black.opacity(0.5), lineWidth: 1).offset(x: 0, y: 1).blur(radius: 0.5))
                        .overlay(Circle().stroke(Color.gray, lineWidth: 0.5))
                        .frame(height: self.circleHeight)
                        .position(x: self.clippedValue * (proxy.size.width-self.circleHeight)+self.circleHeight/2, y: proxy.size.height/2)
                }
            }
            .coordinateSpace(name: "IOS6Slider")
            .frame(height: circleHeight)
            .listRowInsets(.init(top: 8.5, leading: 14, bottom: 9.5, trailing: 14))
        }
        
        var clippedValue: CGFloat {
            min(max(configuration.value, 0), 1)
        }
    }
}
