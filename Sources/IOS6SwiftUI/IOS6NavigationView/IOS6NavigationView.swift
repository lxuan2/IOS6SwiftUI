//
//  IOS6NavigationView.swift
//  animation
//
//  Created by Xuan Li on 1/15/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI
var viewStack: IOS6NavigationStack? = nil

/// A view for presenting a stack of views representing a visible path in a
/// navigation hierarchy.
public struct IOS6NavigationView<Content: View>: View {
    let title: String
    let interactiveSwipe: Bool
    
    public var body: some View {
        VStack(spacing: 0) {
            IOS6NavigationBar()
                .zIndex(1)
            
            IOS6NavigationSubView(interactiveSwipe: interactiveSwipe)
                .zIndex(0)
                .edgesIgnoringSafeArea(.bottom)
        }
        .background(IOS6NavigationWallpaper())
        .environmentObject(viewStack ?? IOS6NavigationStack(rootView: EmptyView(), title: ""))
        .colorScheme(.light)
    }
    
    public init(_ title: String, interactiveSwipe: Bool = false, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.interactiveSwipe = interactiveSwipe
        viewStack = IOS6NavigationStack(rootView: content(), title: title)
        
    }
    
    struct IOS6NavigationSubView: View {
        let navigationBarHeight: CGFloat = 45
        let interactiveSwipe: Bool
        @EnvironmentObject var viewStack: IOS6NavigationStack
        
        var body: some View {
            GeometryReader { proxy in
                ZStack(alignment: .leading) {
                    ZStack {
                        ForEach(0 ..< self.viewStack.count, id: \.self) { index in
                            self.viewStack[index].content
                                .transition(.move(edge: .trailing))
                                .offset(x: index < self.viewStack.count - 2 ? -proxy.size.width :
                                    index == self.viewStack.count - 2 ? -proxy.size.width + self.viewStack.dragAmount :
                                    self.viewStack.dragAmount,
                                        y: 0)
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
    }
}

struct IOS6NavigationView_Previews: PreviewProvider {
    static var previews: some View {
        IOS6NavigationView("Settings") {
            Text("Navigation View")
        }
    }
}
