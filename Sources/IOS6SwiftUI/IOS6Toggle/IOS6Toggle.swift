//
//  IOS6Toggle.swift
//  animation
//
//  Created by Xuan Li on 2/10/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

/// A control that toggles between "on" and "off" states with IOS 6 style.
public struct IOS6Toggle: View {
    let height: CGFloat = 26
    let width: CGFloat = 74
    let color: Color
    
    @GestureState private var isPressed: Bool = false
    @State private var oldPercent: CGFloat
    @State private var percent: CGFloat
    @Binding private var isOn: Bool {
        didSet {
            withAnimation(.easeInOut(duration: self.percent == self.oldPercent ? 0.27:0.1)) {
                self.oldPercent = isOn ? self.width - self.height / 2:self.height / 2
                self.percent = self.oldPercent
            }
        }
    }
    
    public init(isOn: Binding<Bool>, toggleColor: Color = Color(red: 0/255.0, green: 127/255.0, blue: 234/255.0)) {
        _isOn = isOn
        _oldPercent = State(initialValue: isOn.wrappedValue ? self.width - self.height / 2:self.height / 2)
        _percent = _oldPercent
        self.color = toggleColor
    }
    
    public var body: some View {
        ZStack {
            IOS6ToggleBackground(color: color, offset: isPressed ? percent: isOn ? self.width - self.height / 2:self.height / 2)
            RoundedRectangle(cornerRadius: 9)
                .fill(
                    LinearGradient(
                        gradient:
                        Gradient(colors:
                            [Color.white.opacity(0.15),
                             Color.white.opacity(0.45),
                             Color.white]),
                        startPoint: .top,
                        endPoint: .bottom))
                .frame(width: width - height / 3)
                .offset(x: 0, y: height/2)
                
            IOS6ToggleBoundary()
            IOS6ToggleCircleButton(isPressed: isPressed, offset:  isPressed ? percent: isOn ? self.width - self.height / 2:self.height / 2)
        }
        .clipShape(Capsule())
        .frame(width: self.width, height: self.height)
        .simultaneousGesture(
            LongPressGesture(minimumDuration: .infinity, maximumDistance: .infinity)
                .updating($isPressed) { currentState, gestureState, transaction in
                    gestureState = currentState
            }
        )
            .simultaneousGesture(
                DragGesture(minimumDistance: 10)
                    .onChanged { value in
                        let newPercent = self.oldPercent + value.translation.width
                        self.percent = newPercent < self.height / 2 ? self.height / 2 :
                            newPercent > self.width - self.height / 2 ? self.width - self.height / 2 :
                        newPercent
                }
                .onEnded { value in
                    self.isOn = self.oldPercent + value.translation.width >= self.width / 2
                }
                .exclusively(before: TapGesture().onEnded {
                    self.isOn = self.isOn ? false: true
                })
        )
        
    }
    
    struct IOS6Toggle_Previews: PreviewProvider {
        static var previews: some View {
            IOS6Toggle(isOn: .constant(false))
        }
    }
    
    struct IOS6ToggleBackground: View {
        let color: Color
        let offset: CGFloat
        
        var body: some View {
            GeometryReader { geo in
                ZStack {
                    HStack(spacing: 0) {
                        self.color
                            .frame(width: geo.size.width)
                        Color(red: 238.0/255.0, green: 238.0/255.0, blue: 238.0/255.0)
                            .frame(width: geo.size.width).blendMode(.screen)
                    }.frame(width: geo.size.width)
                    
                    Text("OFF")
                        .offset(x: geo.size.width/2.2, y: 0)
                        .foregroundColor(Color(red: 120.0/255.0, green: 120.0/255.0, blue: 120.0/255.0))
                        .font(Font.callout.weight(.bold))
                    
                    ZStack {
                        Text("ON")
                            .foregroundColor(Color.black.opacity(0.5))
                            .offset(x: 0, y: -0.5)
                        
                        Text("ON")
                            .foregroundColor(.white)
                    }
                    .font(Font.callout.weight(.bold))
                    .offset(x: -geo.size.width/2.2, y: 0)
                }
                .compositingGroup()
                .offset(x: self.offset - 0.5 * geo.size.width, y: 0)
            }
        }
    }
    
    struct IOS6ToggleButton: View {
        let workSpaceHeight: CGFloat
        let workSpaceWidth: CGFloat
        let offset: CGFloat
        
        @State private var isPressed: Bool = false
        
        var body: some View {
            Button(action: {}, label: {EmptyView()})
                .buttonStyle(IOS6ToggleButtonStyle())
                .offset(x: offset - 0.5 * workSpaceWidth, y: 0)
        }
    }
    
    struct IOS6ToggleButtonStyle: ButtonStyle {
        
        public func makeBody(configuration: IOS6ToggleButtonStyle.Configuration) -> some View {
            iOS6ToggleButton(configuration: configuration)
        }
        
        struct iOS6ToggleButton: View {
            let configuration: IOS6ToggleButtonStyle.Configuration
            
            var body: some View {
                GeometryReader { geo in
                    ZStack {
                        Circle()
                            .fill(Color.white)
                        
                        Circle()
                            .fill(
                                LinearGradient(
                                    gradient:
                                    Gradient(colors:
                                        [Color.black.opacity(self.configuration.isPressed ? 0.10 : 0.08),
                                         //Color.black.opacity(self.configuration.isPressed ? 0.11 : 0.05),
                                         Color.black.opacity(self.configuration.isPressed ? 0.09 : 0.0)]),
                                    startPoint: .top,
                                    endPoint: .bottom))
                        
                        Circle()
                            .strokeBorder(
                                Color.white,
                                lineWidth: 1)
                            .blur(radius: 0.35)
                            .frame(height: geo.size.height - 1)
                        
                        Circle()
                            .strokeBorder(
                                Color(red: 100.0/255.0, green: 100.0/255.0, blue: 100.0/255.0),
                                lineWidth: 0.4)
                    }
                    .compositingGroup()
                    .shadow(color:Color.black.opacity(0.12), radius: 0.3)
                    .frame(height: geo.size.height - 1)
                }
                
            }
        }
        
    }
    
    struct IOS6ToggleBoundary: View {
        
        var body: some View {
            GeometryReader { geo in
                Group {
                    Capsule()
                        .strokeBorder(
                            Color(red: 180/255.0, green: 180/255.0, blue: 180/255.0),
                            lineWidth: 0.6)
                        .blur(radius: 0.3)
                    
                    Capsule()
                        .strokeBorder(Color.black.opacity(0.6), lineWidth: 1.1)
                        .blur(radius: 1.4)
                        .padding(EdgeInsets(top: 0.18, leading: -3, bottom: -4.5, trailing: -3))
                }
            }
        }
    }
    
    struct IOS6ToggleCircleButton: View {
        let isPressed: Bool
        let offset: CGFloat
        
        var body: some View {
            GeometryReader { geo in
                ZStack {
                    Circle()
                        .fill(Color.white)
                    
                    Circle()
                        .fill(
                            LinearGradient(
                                gradient:
                                Gradient(colors:
                                    [Color.black.opacity(self.isPressed ? 0.20 : 0.20),
                                     Color.black.opacity(self.isPressed ? 0.1 : 0.0)]),
                                startPoint: .top,
                                endPoint: .bottom))
                    
                    Circle()
                        .strokeBorder(
                            Color.white,
                            lineWidth: 0.85)
                        .frame(height: geo.size.height - 1)
                    
                    Circle()
                        .strokeBorder(
                            Color(red: 140.0/255.0, green: 140.0/255.0, blue: 140.0/255.0),
                            lineWidth: 0.65)
                }
                .shadow(color:Color.black.opacity(0.1), radius: 0.1)
                .offset(x: self.offset - 0.5 * geo.size.width, y: 0)
            }
        }
    }
}
