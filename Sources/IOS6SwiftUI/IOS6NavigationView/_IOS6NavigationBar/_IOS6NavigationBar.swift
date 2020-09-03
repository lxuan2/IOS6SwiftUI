//
//  _IOS6NavigationBar.swift
//  animation
//
//  Created by Xuan Li on 2/4/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

/// `Private API`:
struct _IOS6NavigationBar<BarBackButton: View>: View {
    @Environment(\.isEnabled) private var isEnabled
    let data: [_IOS6NavigationBarData]
    let width: CGFloat
    let offset: CGFloat
    let dismiss: () -> Void
    let makeBarButton: (IOS6NavigationBarBackButtonConfiguration) -> BarBackButton
    private let decay: CGFloat = 2
    
    var body: some View {
        ZStack {
            ForEach(data) { comp in
                _IOS6NavigationBarPageView(title: comp.title,
                                           backTitle: comp.backTitle,
                                           noBackTitle: comp.noBackTitle,
                                           dismiss: self.dismiss,
                                           makeBarButton: self.makeBarButton,
                                           width: self.width,
                                           height: 44)
                    .compositingGroup()
                    .frame(width: self.width)
                    .transition(comp.id < self.data[1].id ? .identity:.moveInXAndFade(offset: self.width / self.decay))
                    .offset(x: comp.id < self.data[1].id ? -self.width+self.offset:self.offset/self.decay, y: 0)
                    .opacity(!self.isEnabled ? 0 : comp.id < self.data[1].id ? Double(self.offset / self.width) : 1-Double(self.offset / self.width))
            }
        }
        .frame(height: 44)
    }
    
    func decayRatio(_ value: CGFloat) -> CGFloat {
        value < 0 ? 1 : decay
    }
}

struct _IOS6NavigationBarData: Identifiable, Equatable {
    var id: Int
    var title: String?
    var backTitle: String?
    var noBackTitle: Bool = false
}

func buildNavigationBarData(titles: [String?]) -> [_IOS6NavigationBarData] {
    var ts: [_IOS6NavigationBarData] = []
    switch titles.count {
    case 3...:
        ts.append(_IOS6NavigationBarData(id: titles.count-2, title: titles[titles.count-2], backTitle: titles[titles.count-3], noBackTitle: false))
        ts.append(_IOS6NavigationBarData(id: titles.count-1, title: titles[titles.count-1], backTitle: titles[titles.count-2], noBackTitle: false))
    case 2:
        ts.append(_IOS6NavigationBarData(id: 0, title: titles[0], backTitle: nil, noBackTitle: true))
        ts.append(_IOS6NavigationBarData(id: 1, title: titles[1], backTitle: titles[0], noBackTitle: false))
    case 1:
        ts.append(_IOS6NavigationBarData(id: -1, title: "", backTitle: nil, noBackTitle: true))
        ts.append(_IOS6NavigationBarData(id: 0, title: titles[0], backTitle: nil, noBackTitle: true))
    default:
        ts.append(_IOS6NavigationBarData(id: -1, title: "", backTitle: nil, noBackTitle: true))
        ts.append(_IOS6NavigationBarData(id: 0, title: "", backTitle: nil, noBackTitle: true))
    }
    return ts
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
