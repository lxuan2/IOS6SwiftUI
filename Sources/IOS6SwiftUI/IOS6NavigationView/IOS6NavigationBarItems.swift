//
//  IOS6NavigationBarItems.swift
//  animation
//
//  Created by Xuan Li on 2/4/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct IOS6NavigationBarItems: View {
    @EnvironmentObject var viewStack: IOS6NavigationViewStack
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                ForEach(0 ..< self.viewStack.stack.count, id: \.self) { index in
                    self.bartextview(at: index, width: proxy.size.width)
                }
            }
        }
    }
    
    func bartextview(at index: Int, width: CGFloat) -> some View {
        var offset: CGFloat = 0
        var opacity: Double = 0
        if index < self.viewStack.stack.count - 2 {
            offset = -width
            opacity = 0
        } else if index == self.viewStack.stack.count - 2 {
            offset = -width + self.viewStack.dragAmount
            opacity = Double(self.viewStack.dragAmount / width)
        } else {
            offset = self.viewStack.dragAmount
            opacity = Double(1 - self.viewStack.dragAmount / width)
        }
        return
            ZStack {
                Text(self.viewStack.titleStack[index])
                    .foregroundColor(Color.black.opacity(0.5))
                    .offset(x: 0, y: -1.1)
                Text(self.viewStack.titleStack[index])
                    .foregroundColor(.white)
            }
            .font(Font.system(size: 20, weight: .bold))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(
                ZStack {
                    if index > 0 {
                        Button(self.viewStack.titleStack[index - 1].isEmpty ? "Back" : self.viewStack.titleStack[index - 1]) {
                            self.viewStack.pop()
                        }
                        .buttonStyle(IOS6NavigationBackButtonStyle())
                        .padding(.leading, 5.5)
                    }
                },
                alignment: .leading)
                .compositingGroup()
                .transition(.moveInXAndFade(offset: width / 3))
                .offset(x: offset, y: 0)
                .opacity(opacity)
                .clipped()
    }
}

struct IOS6NavigationBarItems_Previews: PreviewProvider {
    static var previews: some View {
        IOS6NavigationBarItems()
    }
}

struct MoveInXAndFade: ViewModifier {
    var opacity: Double
    var offset: CGFloat
    
    func body(content: Content) -> some View {
        content
            .offset(x: offset, y: 0)
            .opacity(opacity)
    }
}

extension AnyTransition {
    static func moveInXAndFade(offset: CGFloat) -> AnyTransition {
        AnyTransition.modifier(
            active: MoveInXAndFade(opacity: 0, offset: offset),
            identity: MoveInXAndFade(opacity: 1, offset: 0))
    }
}
