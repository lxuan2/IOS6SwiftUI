//
//  IOS6NavigationBackButtonStyle.swift
//  animation
//
//  Created by Xuan Li on 2/4/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI
struct IOS6NavigationBackButtonStyle: PrimitiveButtonStyle {
    public func makeBody(configuration: IOS6NavigationBackButtonStyle.Configuration) -> some View {
        IOS6NavigationBackButton(configuration: configuration)
    }
    
    struct IOS6NavigationBackButton: View {
        let configuration: IOS6NavigationBackButtonStyle.Configuration
        let height: CGFloat = 25
        @State private var isPressed: Bool = false
        @State private var isValid: Bool = true
        
        var body: some View {
            let gesture = DragGesture(minimumDistance: 0)
                .onChanged { value in
                    if self.isValid  {
                        if value.translation.height >= 80 {
                            self.isValid = false
                            self.isPressed = false
                        }
                        else if value.translation.width > 80 {
                            self.configuration.trigger()
                        }
                        else {
                            self.isPressed = true
                        }
                    }
                }
                .onEnded { _ in
                    self.isPressed = false
                    if self.isValid {
                        self.configuration.trigger()
                    }
                    self.isValid = true
                }
            
            return ZStack {
                IOS6NavigationBackButtonShape()
                    .fill(Color.white)
                    .offset(x: 0, y: 0.5)
                    .blur(radius: 0.4)
                    
                IOS6NavigationBackButtonShape()
                    .fill(isPressed ?
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
                        IOS6NavigationBackButtonShape()
                            .stroke(Color(red: 51.0/255.0, green: 72.0/255.0, blue: 105.0/255.0), lineWidth: 1))
                    .overlay(
                    IOS6NavigationBackButtonShape()
                        .stroke(Color(red: 30/255.0, green: 40/255.0, blue: 50/255.0), lineWidth: 1)
                        .blur(radius: 0.4)
                        .offset(x: 0, y: 0.4))
                    .clipShape(IOS6NavigationBackButtonShape())
                    
                    
                configuration.label
                    .foregroundColor(Color.black.opacity(0.6))
                    .font(Font.system(size: 11.5, weight: .bold))
                    .padding(.leading, height / 2)
                    .padding([.vertical, .trailing], height / 3.01)
                    .offset(x: 0, y: -1)
                
                configuration.label
                    .foregroundColor(.white)
                    .font(Font.system(size: 11.5, weight: .bold))
                    .padding(.leading, height / 2)
                    .padding([.vertical, .trailing], height / 2.9)
                    .layoutPriority(1)
                    .frame(minWidth: 30)
            }.gesture(gesture)
            
        }
    }
}

struct IOS6NavigationBackButtonShape: Shape {
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let arrowX: CGFloat = rect.maxY / 2.2
        let minWidth: CGFloat = 5
        
        let control1_X: CGFloat = rect.maxY / 4.5
        let control1_Y: CGFloat = rect.maxY / 6
        let control2_X: CGFloat = rect.maxY / 3
        let control2_Y: CGFloat = 0
        
        let radius: CGFloat = rect.maxY / 5
        
        path.move(to: CGPoint(x: 0, y: rect.midY))
        path.addCurve(to: CGPoint(x: arrowX, y: 0),
                    control1: CGPoint(x: control1_X, y: control1_Y),
                    control2: CGPoint(x: control2_X, y: control2_Y))
        path.addLine(to: CGPoint(x: rect.maxX - minWidth, y: 0))
        path.addArc(tangent1End: CGPoint(x: rect.maxX, y: 0),
                    tangent2End: CGPoint(x: rect.maxX, y: minWidth),
                    radius: radius)
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - minWidth))
        path.addArc(tangent1End: CGPoint(x: rect.maxX, y: rect.maxY),
                    tangent2End: CGPoint(x: rect.maxX - minWidth , y: rect.maxY),
                    radius: radius)
        path.addLine(to: CGPoint(x: arrowX, y: rect.maxY))
        path.addCurve(to: CGPoint(x: 0, y: rect.midY),
                    control1: CGPoint(x: control2_X, y: rect.maxY - control2_Y),
                    control2: CGPoint(x: control1_X, y: rect.maxY - control1_Y))
        
        return path
    }
}

struct IOS6NavigationBackButton_Previews: PreviewProvider {
    static var previews: some View {
        Button("Back to First") {
            
        }
            .buttonStyle(IOS6NavigationBackButtonStyle())
        //IOS6NavigationBackButtonShape().fill(Color.blue).frame(width: 80, height: 30)
    }
}
