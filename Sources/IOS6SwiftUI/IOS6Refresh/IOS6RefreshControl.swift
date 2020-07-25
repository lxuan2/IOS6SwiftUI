//
//  IOS6RefreshControl.swift
//  IOS6
//
//  Created by Xuan Li on 7/22/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct IOS6RefreshControl: View {
    @Binding private var shift: CGFloat
    let onRefresh: (() -> Void)?
    @Binding private var padding: CGFloat
    @State private var state: _IOS6RefreshControlState = .idle
    
    init(shift: Binding<CGFloat>, padding: Binding<CGFloat>, onRefresh: (() -> Void)? = nil) {
        self._shift = shift
        self.onRefresh = onRefresh
        self._padding = padding
    }
    
    var body: some View {
        switch state {
        case .idle:
            if shift >= 96 {
                DispatchQueue.global().async {
                    withAnimation {
                        self.state = .busy
                        self.padding = IOS6RefreshControl.bottomPadding + IOS6RefreshControl.topPadding + IOS6RefreshControl.maxTopRadius * 2
                    }
                    self.onRefresh?()
                    withAnimation {
                        self.state = .finish
                    }
                }
            }
        case .busy:
            break
        case .finish:
            if shift == 0 {
                DispatchQueue.main.async {
                    withAnimation(Animation.default) {
                        self.state = .idle
                        self.padding = 0
                    }
                }
            }
        }
        
        return
            ZStack {
                if state == .idle {
                    _IOS6RefreshControlShape()
                        .fill(Color.blue)
                        .transition(.asymmetric(insertion: .identity, removal: AnyTransition.scale.combined(with: .offset(x: 0, y: -26.5))))
                        .offset(x: 0, y: offset)
                        .frame(width: IOS6RefreshControl.maxTopRadius * 2, height: height)
                        .padding(.top, IOS6RefreshControl.topPadding)
                        .padding(.bottom, IOS6RefreshControl.bottomPadding)
                } else {
                    Circle()
                        .fill(state == .busy ? Color.red : .yellow)
                        .transition(
                            .asymmetric(insertion: AnyTransition.scale.animation(Animation.spring().delay(0.2)),
                                        removal: AnyTransition.scale.combined(with:
                                            .offset(x: 0,
                                                    y: -IOS6RefreshControl.bottomPadding - IOS6RefreshControl.topPadding - IOS6RefreshControl.maxTopRadius * 2))))
                        .offset(x: 0, y: min(0, shift))
                        .frame(width: IOS6RefreshControl.maxTopRadius * 2, height: IOS6RefreshControl.maxTopRadius * 2)
                        .padding(.top, IOS6RefreshControl.topPadding)
                        .padding(.bottom, IOS6RefreshControl.bottomPadding)
                }
        }.drawingGroup()
        
    }
    
    var height: CGFloat {
        min(53,max(0, shift - IOS6RefreshControl.bottomPadding - IOS6RefreshControl.topPadding - IOS6RefreshControl.maxTopRadius * 2)) + IOS6RefreshControl.maxTopRadius * 2
    }
    
    var offset: CGFloat {
        min(0, shift - IOS6RefreshControl.maxTopRadius * 2 - IOS6RefreshControl.bottomPadding - IOS6RefreshControl.topPadding)
    }
    
    static private let maxTopRadius: CGFloat = 16
    static private let minTopRadius: CGFloat = 12.5
    static private let maxBottomRadius: CGFloat = 16
    static private let minBottomRadius: CGFloat = 3
    static private let topPadding: CGFloat = 6
    static private let bottomPadding: CGFloat = 5
    static private let topMaxDistance: CGFloat = 53
    
    private enum _IOS6RefreshControlState {
        case idle
        case busy
        case finish
    }
}

struct _IOS6RefreshControlShape: Shape, InsettableShape {
    
    private var insetAmount: CGFloat = 0
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRect(rect)
        
        return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
}
