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
    let interactiveSwipe: Bool
    
    public var body: some View {
        IOS6NavigationSubView(interactiveSwipe: interactiveSwipe)
            .environmentObject(IOS6NavigationViewStack(rootView: self.content(), title: title))
            .colorScheme(.light)
    }
    
    public init(_ title: String, interactiveSwipe: Bool = false, @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.title = title
        self.interactiveSwipe = interactiveSwipe
    }
    
    struct IOS6NavigationSubView: View {
        let navigationBarHeight: CGFloat = 45
        let interactiveSwipe: Bool
        @EnvironmentObject var viewStack: IOS6NavigationViewStack

        var body: some View {
            VStack(spacing: 0) {
                Spacer(minLength: navigationBarHeight)
                
                ZStack {
                    ForEach(0 ..< viewStack.count(), id: \.self) { index in
                        self.viewStack.item(of: index)
                            .offset(x: self.viewStack.offsetStack[index], y: 0)
                            .environment(\.enableView, index == self.viewStack.count() - 1)
                    }
                }.edgesIgnoringSafeArea([.horizontal,.bottom])
            .gesture(
                    DragGesture(minimumDistance: 1)
                        .onChanged { value in
                            if self.interactiveSwipe && self.viewStack.offsetStack.count > 1 {
                                let offset = value.startLocation.x < 30 ? value.translation.width : 0
                                self.viewStack.updateOffset(newOffset: offset)
                            }
                    }
                    .onEnded { value in
                        if self.viewStack.count() > 1 {
                            if value.predictedEndTranslation.width - value.translation.width > 20 || self.viewStack.offsetStack[self.viewStack.offsetStack.count - 1] > UIScreen.main.bounds.width / 2 {
                                let scale = self.interactiveSwipe ? (UIScreen.main.bounds.width - value.translation.width) / UIScreen.main.bounds.width : 1
                                self.viewStack.pop(scale: Double(scale))
                            } else {
                                withAnimation(.easeInOut(duration: 0.2)) {
                                self.viewStack.updateOffset(newOffset: 0)
                                }
                            }
                        }
                    }
                )
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
