//
//  _IOS6NavigationBar.swift
//  animation
//
//  Created by Xuan Li on 2/4/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

/// `Private API`:
struct _IOS6NavigationBar: View {
    @EnvironmentObject private var stack: _IOS6NavigationStack
    @Environment(\.isEnabled) private var isEnabled
    let width: CGFloat
    private let decay: CGFloat = 2
    
    var body: some View {
        ZStack {
            Spacer()
            ForEach(stack) { page in
                _IOS6NavigationBarPageView(title: self.stack.barStack[page.id],
                                          backTitle: self.stack.before(page.id),
                                          index: page.id,
                                          dismiss: {self.stack.pop(to: page.id)})
                    .transition(.moveInXAndFade(offset: self.width / self.decay))
                    .offset(x: self.stack.offsetStack[page.id] * self.width / self.decayRatio(self.stack.offsetStack[page.id]), y: 0)
                    .opacity(Double(1 - abs(self.stack.offsetStack[page.id])))
            }
        }
            .clipped()
            .opacity(self.isEnabled ? 1 : 0.8)
            .background(background.edgesIgnoringSafeArea([.horizontal, .bottom]))
            .frame(height: 44)
    }
    
    var background: some View {
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
                    Color(red: 233/255, green: 244/255, blue: 255/255)
                        .frame(height: 0.5)
                    
                    Spacer()
                    
                    Color(red: 69/255, green: 91/255, blue: 125/255)
                        .frame(height: 1)
                }
        )
    }
    
    func decayRatio(_ value: CGFloat) -> CGFloat {
        value < 0 ? 1 : decay
    }
}


/// `Private API`:
/// A ViewModifer combining opacity and offset.
struct MoveInXAndFade: ViewModifier {
    var opacity: Double
    var offset: CGFloat
    
    init(_ tuple: (Double, CGFloat)) {
        opacity = tuple.0
        offset = tuple.1
    }
    
    func body(content: Content) -> some View {
        content
            .offset(x: offset, y: 0)
            .opacity(opacity)
    }
}

extension AnyTransition {
    /// Transition with moving in and opacity.
    /// - Parameter offset: offset amount
    /// - Returns: any transition
    static func moveInXAndFade(offset: CGFloat) -> AnyTransition {
        AnyTransition.modifier(
            active: MoveInXAndFade((0, offset)),
            identity: MoveInXAndFade((1, 0)))
    }
}
