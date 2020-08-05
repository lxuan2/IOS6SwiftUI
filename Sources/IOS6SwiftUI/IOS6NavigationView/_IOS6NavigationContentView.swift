//
//  IOS6NavigationContentView.swift
//  IOS6
//
//  Created by Xuan Li on 5/5/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

/// `Private API`:
struct _IOS6NavigationContentView: View {
    @EnvironmentObject private var stack: _IOS6NavigationStack
    let width: CGFloat
    
    var body: some View {
        ZStack {
            ForEach(stack) { page in
                page
                    .transition(.move(edge: .trailing))
                    .offset(x: self.stack.offsetStack[page.id] * self.width, y: 0)
                    .onPreferenceChange(_IOS6NavigationBarTitleKey.self) { self.stack.updateTitle(at: page.id, with: $0) }
                    .onAppear { self.stack.transIn(page.id) }
            }
        }
    }
}

struct IOS6NavigationContentView_Previews: PreviewProvider {
    static var previews: some View {
        _IOS6NavigationContentView(width: 200)
    }
}
