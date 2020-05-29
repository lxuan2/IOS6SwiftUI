//
//  IOS6NavigationContentView.swift
//  IOS6
//
//  Created by Xuan Li on 5/5/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct IOS6NavigationContentView: View {
    let navigationBarHeight: CGFloat = 45
    let interactiveSwipe: Bool
    @EnvironmentObject var viewStack: IOS6NavigationStack
    
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .leading) {
                ZStack {
                    ForEach(self.viewStack) { page in
                        page
                            .transition(.move(edge: .trailing))
                            .offset(x: self.amount(page, proxy.size.width), y: 0)
                            .onPreferenceChange(IOS6NavigationBarTitleKey.self) { title in
                                self.viewStack.updateTitle(at: page.id, with: title)
                        }
                    }
                }
                .compositingGroup()
                .gesture(TapGesture(), including: self.viewStack.blocking ? .none: .subviews)
                
                if self.interactiveSwipe {
                    Color.clear
                        .frame(width: self.viewStack.blocking ? 0 : 20)
                        .contentShape(Rectangle())
                        .gesture(
                            DragGesture()
                                .onChanged { self.viewStack.updateOffset(with: $0) }
                                .onEnded { self.viewStack.endOffset(with: $0, in: proxy) }
                    )
                }
            }
        }
    }
    
    func amount(_ view: IOS6NavigationStack.Element, _ width: CGFloat) -> CGFloat {
        if view.id < self.viewStack.count - 2 {
            return -width
        } else if view.id == self.viewStack.count - 2 {
            return -width + self.viewStack.dragAmount
        } else {
            return self.viewStack.dragAmount
        }
    }
}

struct IOS6NavigationContentView_Previews: PreviewProvider {
    static var previews: some View {
        IOS6NavigationContentView(interactiveSwipe: true)
    }
}
