//
//  IOS6ToggleView.swift
//  IOS6
//
//  Created by Xuan Li on 5/8/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

public struct IOS6ToggleView: View {
    let height: CGFloat = 26
    let width: CGFloat = 74
    
    @Environment(\.isEnabled) private var isEnabled
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
    
    public init(isOn: Binding<Bool>) {
        _isOn = isOn
        _oldPercent = State(initialValue: isOn.wrappedValue ? self.width - self.height / 2:self.height / 2)
        _percent = _oldPercent
    }
    
    public var body: some View {
        ZStack {
            Background(offset: isPressed ? percent: isOn ? self.width - self.height / 2:self.height / 2)
                .opacity(isEnabled ? 1 : 0.7)
            
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
            //Boundary()
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
    
    struct Boundary: View {
        var body: some View {
            GeometryReader { geo in
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
                    .frame(width: geo.size.width - geo.size.height / 3)
                    .offset(x: 0, y: geo.size.height/2)
                    .overlay(
                        Capsule()
                            .strokeBorder(Color.black.opacity(0.5), lineWidth: 1)
                            .blur(radius: 1.4)
                            .padding(EdgeInsets(top: 0.18, leading: -2.5, bottom: -4.5, trailing: -2.5)))
                    .overlay(
                        Capsule()
                            .strokeBorder(
                                Color(red: 180/255.0, green: 180/255.0, blue: 180/255.0),
                                lineWidth: 0.6)
                            .blur(radius: 0.3))
            }
        }
        
        func halfHeight(_ geo: GeometryProxy) -> CGFloat {
            geo.size.height / 2
        }
        
        func reducedWidth(_ geo: GeometryProxy) -> CGFloat {
            (geo.size.width - geo.size.height / 2) + 1
        }
    }
    
    struct Background: View {
        let offset: CGFloat
        
        @Environment(\.ios6ToggleColor) private var color
        private let white = Color(red: 238.0/255.0, green: 238.0/255.0, blue: 238.0/255.0)
        
        var body: some View {
            GeometryReader { geo in
                HStack(spacing: 0) {
                    self.color
                        .frame(width: self.offset)
                        .overlay(
                            self.onLabel
                                .alignmentGuide(.trailing, computeValue: { d in d[.trailing] + self.pad(geo)}),
                            alignment: .trailing)
                    
                    self.white
                        .frame(width: geo.size.width - self.offset)
                        .overlay(
                            Text("OFF")
                                .foregroundColor(Color(red: 120.0/255.0, green: 120.0/255.0, blue: 120.0/255.0))
                                .font(Font.callout.weight(.bold))
                                .fixedSize()
                                .alignmentGuide(.leading, computeValue: { d in d[.leading] - self.pad(geo)}),
                            alignment: .leading)
                }
            }
        }
        
        var onLabel: some View {
            ZStack {
                Text("ON")
                    .foregroundColor(Color.black.opacity(0.5))
                    .offset(x: 0, y: -0.5)
                
                Text("ON")
                    .foregroundColor(.white)
            }
            .font(Font.callout.weight(.bold))
            .fixedSize()
        }
        
        func pad(_ geo: GeometryProxy) -> CGFloat {
            (geo.size.width - geo.size.height) / 2 - 5
        }
    }
}

struct IOS6ToggleView_Previews: PreviewProvider {
    static var previews: some View {
        IOS6ToggleView(isOn: .constant(false))
    }
}
