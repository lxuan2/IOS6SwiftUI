//
//  _IOS6NavigationBarContentView.swift
//  animation
//
//  Created by Xuan Li on 2/4/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct _IOS6NavigationBarContentView: View {
    @EnvironmentObject private var stack: _IOS6NavigationStack
    let width: CGFloat
    private static let decay: CGFloat = 2
    
    var body: some View {
        ZStack {
            ForEach(stack) { page in
                _IOS6NavigationBarPageView(title: self.stack.barStack[page.id],
                                          backTitle: self.stack.before(page.id),
                                          index: page.id,
                                          dismiss: {self.stack.pop(to: page.id)})
                    .transition(.moveInXAndFade(offset: self.width / _IOS6NavigationBarContentView.decay))
                    .offset(x: self.stack.offsetStack[page.id] * self.width / self.decayRatio(self.stack.offsetStack[page.id]), y: 0)
                    .opacity(Double(1 - abs(self.stack.offsetStack[page.id])))
            }
        }.clipped()
    }
    
    func decayRatio(_ value: CGFloat) -> CGFloat {
        value < 0 ? 1 : _IOS6NavigationBarContentView.decay
    }
}

struct IOS6NavigationBarItems_Previews: PreviewProvider {
    static var previews: some View {
        _IOS6NavigationBarContentView(width: 100)
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

//extension View {
//    func opacityAndOffset(_ tuple: (Double, CGFloat)) -> some View {
//        return self.modifier(MoveInXAndFade(tuple))
//    }
//}


