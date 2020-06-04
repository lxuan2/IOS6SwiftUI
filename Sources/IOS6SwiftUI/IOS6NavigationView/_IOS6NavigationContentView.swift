//
//  IOS6NavigationContentView.swift
//  IOS6
//
//  Created by Xuan Li on 5/5/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct _IOS6NavigationContentView: View {
    @EnvironmentObject private var stack: _IOS6NavigationStack
    let width: CGFloat
    
    var body: some View {
        ZStack {
            ForEach(stack) { page in
                page
                    .transition(.move(edge: .trailing))
                    .offset(x: self.amount(page), y: 0)
                    .onPreferenceChange(_IOS6NavigationBarTitleKey.self) { title in
                        self.stack.updateTitle(at: page.id, with: title)
                }
            }
        }.clipped()
    }
    
    private func amount(_ view: _IOS6NavigationStack.Element) -> CGFloat {
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
        _IOS6NavigationContentView(width: 200)
    }
}
