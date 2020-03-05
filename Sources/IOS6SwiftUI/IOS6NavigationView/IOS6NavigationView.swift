//
//  IOS6NavigationView.swift
//  animation
//
//  Created by Xuan Li on 1/15/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

/// A view for presenting a stack of views representing a visible path in a
/// navigation hierarchy.
public struct IOS6NavigationView<Content: View>: View {
    let title: String
    let content: () -> Content
    
    public var body: some View {
        IOS6NavigationSubView()
            .environmentObject(IOS6NavigationViewStack(rootView: self.content(), title: title))
    }
    
    public init(_ title: String, @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.title = title
    }
    
    struct IOS6NavigationSubView: View {
        let navigationBarHeight: CGFloat = 45
        @EnvironmentObject var viewStack: IOS6NavigationViewStack
        
        var body: some View {
            VStack(spacing: 0) {
                Spacer(minLength: navigationBarHeight)
                ZStack {
                    ForEach(0 ..< viewStack.count(), id: \.self) { index in
                        self.viewStack.item(of: index)
                            .offset(x: index == self.viewStack.count() - 1 ? 0 : -UIScreen.main.bounds.width, y: 0)
                            .environment(\.enableView, index == self.viewStack.count() - 1)
                    }
                }
            }
            .overlay(IOS6NavigationBar(navigationBarHeight: navigationBarHeight),alignment: .top)
            .background(IOS6NavigationWallpaper())
        }
    }
}

struct IOS6NavigationView_Previews: PreviewProvider {
    static var previews: some View {
        IOS6NavigationView("Settings") {
            Text("Navigation View")
        }
    }
}
