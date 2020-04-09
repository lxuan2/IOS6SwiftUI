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
        VStack(spacing: 0) {
            IOS6NavigationBar()
                .zIndex(1)
            
            IOS6NavigationSubView(interactiveSwipe: interactiveSwipe)
                .zIndex(0)
                .clipped()
                .padding(0.5)
                .edgesIgnoringSafeArea(.bottom)
        }
        .background(IOS6NavigationWallpaper())
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
            GeometryReader { proxy in
                ZStack(alignment: .leading) {
                    ZStack {
                        ForEach(0 ..< self.viewStack.stack.count, id: \.self) { index in
                            self.viewStack.stack[index]
                                .offset(x: index < self.viewStack.stack.count - 2 ? -proxy.size.width :
                                    index == self.viewStack.stack.count - 2 ? -proxy.size.width + self.viewStack.dragAmount :
                                    self.viewStack.dragAmount,
                                        y: 0)
                        }
                        .transition(.move(edge: .trailing))
                    }
                    .disabled(self.viewStack.blocking)
                    
                    if self.interactiveSwipe {
                        Color.clear
                            .frame(width: 50)
                            .contentShape(Rectangle())
                            .gesture(
                                DragGesture()
                                    .onChanged{ value in
                                        if self.viewStack.stack.count > 1 {
                                            self.viewStack.dragAmount = value.translation.width
                                            if !self.viewStack.blocking {
                                                self.viewStack.blocking = true
                                            }
                                        }
                                }
                                .onEnded { value in
                                    if self.viewStack.stack.count > 1 {
                                        let half =  proxy.size.width / 2
                                        if value.predictedEndTranslation.width > half || value.translation.width > half  {
                                            let time = 0.35 * Double((proxy.size.width - value.translation.width)/proxy.size.width)
                                            withAnimation(Animation.easeInOut(duration: time)) {
                                                self.viewStack.dragAmount = proxy.size.width
                                            }
                                            withAnimation(.easeIn(duration: time + 0.15)) {
                                                self.viewStack.boolStack.removeLast().wrappedValue = false
                                            }
                                            DispatchQueue.main.asyncAfter(deadline: .now() + time + 0.15 + 0.1) {
                                                self.viewStack.blocking = false
                                                self.viewStack.stack.removeLast()
                                                self.viewStack.titleStack.removeLast()
                                                self.viewStack.dragAmount = 0
                                            }
                                        } else {
                                            withAnimation(Animation.easeInOut(duration: 0.2)) {
                                                self.viewStack.dragAmount = 0
                                            }
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2 + 0.1) {
                                                self.viewStack.blocking = false
                                            }
                                        }
                                    }
                                }
                        )
                    } else {
                        /*@START_MENU_TOKEN@*/EmptyView()/*@END_MENU_TOKEN@*/
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
