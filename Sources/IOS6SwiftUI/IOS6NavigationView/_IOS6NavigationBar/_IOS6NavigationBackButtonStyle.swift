//
//  IOS6NavigationBackButtonStyle.swift
//  animation
//
//  Created by Xuan Li on 2/4/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

/// `Private API`:
/// IOS6 Navigation Back button style.
struct _IOS6NavigationBackButtonStyle<Appearance: IOS6NavigationAppearance>: PrimitiveButtonStyle {
    let appearance: Appearance
    
    func makeBody(configuration: _IOS6NavigationBackButtonStyle.Configuration) -> some View {
        _IOS6NavigationBackButton(configuration: configuration, appearance: appearance)
    }
    
    private struct _IOS6NavigationBackButton<NavigationConfiguration: IOS6NavigationAppearance>: View {
        let configuration: _IOS6NavigationBackButtonStyle.Configuration
        let appearance: NavigationConfiguration
        let height: CGFloat = 25
        @State private var isPressed: Bool = false
        @State private var isValid: Bool = true
        
        var body: some View {
            let gesture = DragGesture(minimumDistance: 0)
                .onChanged { value in
                    if self.isValid  {
                        if value.translation.height >= 60 {
                            self.isValid = false
                            self.isPressed = false
                        }
                        else if value.translation.width > 60 {
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
            let con = IOS6NavigationBarBackButtonConfiguration(label: configuration.label, isPressed: isPressed)
            return appearance.makeNavigationBarBackButtonBody(configuration: con)
                .gesture(gesture)
        }
    }
}

/// `Private API`:
/// IOS6 Navigation Back button Shape.
struct _IOS6NavigationBackButtonShape: Shape {
    
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
