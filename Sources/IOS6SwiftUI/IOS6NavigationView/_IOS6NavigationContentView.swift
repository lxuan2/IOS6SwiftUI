//
//  IOS6NavigationContentView.swift
//  IOS6
//
//  Created by Xuan Li on 5/5/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct _IOS6NavigationContentView: View {
    let navigationBarHeight: CGFloat = 45
    let interactiveSwipe: Bool
    @EnvironmentObject private var stack: _IOS6NavigationStack
    
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .leading) {
                ZStack {
                    ForEach(self.stack) { page in
                        page
                            .transition(.move(edge: .trailing))
                            .offset(x: self.amount(page, proxy.size.width), y: 0)
                            .onPreferenceChange(_IOS6NavigationBarTitleKey.self) { title in
                                self.stack.updateTitle(at: page.id, with: title)
                        }
                    }
                }
                .compositingGroup()
                .gesture(TapGesture(), including: self.stack.blocking ? .none: .subviews)
                
                if self.interactiveSwipe {
                    Color.clear
                        .frame(width: self.stack.blocking ? 0 : 20)
                        .contentShape(Rectangle())
                        .gesture(
                            DragGesture()
                                .onChanged { self.stack.updateOffset(with: $0) }
                                .onEnded { self.stack.endOffset(with: $0, in: proxy) }
                    )
                }
            }
        }
    }
    
    private func amount(_ view: _IOS6NavigationStack.Element, _ width: CGFloat) -> CGFloat {
        if view.id < self.stack.count - 2 {
            return -width
        } else if view.id == self.stack.count - 2 {
            return -width + self.stack.dragAmount
        } else {
            return self.stack.dragAmount
        }
    }
}

struct IOS6NavigationContentView_Previews: PreviewProvider {
    static var previews: some View {
        _IOS6NavigationContentView(interactiveSwipe: true)
    }
}
