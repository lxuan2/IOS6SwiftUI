//
//  IOS6NavigationBarItems.swift
//  animation
//
//  Created by Xuan Li on 2/4/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct IOS6NavigationBarItems: View {
    @EnvironmentObject private var viewStack: IOS6NavigationStack
    let width: CGFloat
    
    var body: some View {
        ZStack {
            ForEach(0 ..< self.viewStack.count, id: \.self) { index in
                IOS6NavigationBarPageView(title: self.viewStack.barStack[index],
                                          backTitle: self.viewStack.before(index),
                                          index: index,
                                          dismiss: {self.viewStack.pop()})
                    .transition(.moveInXAndFade(offset: self.width / 3))
                    .opacityAndOffset(self.parameters(at: index))
            }
        }
    }
    
    func parameters(at index: Int) -> (Double, CGFloat) {
        var offset: CGFloat = 0
        var opacity: Double = 0
        if index < self.viewStack.count - 2 {
            offset = -width
            opacity = 0
        } else if index == self.viewStack.count - 2 {
            offset = -width + self.viewStack.dragAmount
            opacity = Double(self.viewStack.dragAmount / width)
        } else {
            offset = self.viewStack.dragAmount / 3
            opacity = Double(1 - self.viewStack.dragAmount / width)
        }
        return (opacity, offset)
    }
    
}

struct IOS6NavigationBarItems_Previews: PreviewProvider {
    static var previews: some View {
        IOS6NavigationBarItems(width: 100)
    }
}

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
    static func moveInXAndFade(offset: CGFloat) -> AnyTransition {
        AnyTransition.modifier(
            active: MoveInXAndFade((0, offset)),
            identity: MoveInXAndFade((1, 0)))
    }
}

extension View {
    func opacityAndOffset(_ tuple: (Double, CGFloat)) -> some View {
        return self.modifier(MoveInXAndFade(tuple))
    }
}


