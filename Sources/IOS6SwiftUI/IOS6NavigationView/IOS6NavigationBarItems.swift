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
    let navigationBarHeight: CGFloat
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                ForEach(0 ..< self.viewStack.count(), id: \.self) { index in
                    BarTextView(viewStack: self.viewStack, index: index)
                        .offset(x: index == self.viewStack.count() - 1 ? 0 : -geo.size.width / 2, y: 0)
                        .opacity(index == self.viewStack.count() - 1 ? 1 : 0)
                        .transition(.moveInXAndFade(offset: geo.size.width / 3))
                }
            }
        }
    }
}

struct BarTextView: View {
    let viewStack: IOS6NavigationViewStack
    let index: Int
    
    var body: some View {
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
    }
}

struct MoveInXAndFade: ViewModifier {
    var isEnabled: Bool
    var offsetAmount: CGFloat
    
    func body(content: Content) -> some View {
        return content
            .offset(x: offsetAmount, y: 0)
            .opacity(isEnabled ? 0 : 1)
    }
}

extension AnyTransition {
    static func moveInXAndFade(offset: CGFloat) -> AnyTransition {
        AnyTransition.modifier(
            active: MoveInXAndFade(isEnabled: true, offsetAmount: offset),
            identity: MoveInXAndFade(isEnabled: false, offsetAmount: 0))
    }
}

struct IOS6NavigationBarItems_Previews: PreviewProvider {
    static var previews: some View {
        IOS6NavigationBarItems(navigationBarHeight: 45)
    }
}
