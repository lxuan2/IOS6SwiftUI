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
    private let interactiveSwipe: Bool
    @ObservedObject private var stack: _IOS6NavigationStack
    private let debounceDistance: CGFloat = 10
    
    public var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 0) {
                _IOS6NavigationBar()
                    .padding(.top, proxy.safeAreaInsets.top)
                    .zIndex(1)
                
                ZStack(alignment: .leading) {
                    _IOS6NavigationContentView(width: proxy.size.width)
                        .allowsHitTesting(!self.stack.blocking)
                        
                    if self.interactiveSwipe {
                        Color.clear
                            .frame(width: 20 + proxy.safeAreaInsets.leading)
                            .contentShape(Rectangle())
                            .gesture(
                                DragGesture(minimumDistance: self.debounceDistance, coordinateSpace: .global)
                                    .onChanged {
                                        self.stack.updateOffset((($0.translation.width - self.debounceDistance) / proxy.size.width))
                                }
                                .onEnded { self.stack.endOffset(with: $0, in: proxy) }
                        )
                    }
                }.zIndex(0)
            }
        }
        .background(_IOS6NavigationWallpaper())
        .environment(\._ios6NavigationStack, stack)
        .environmentObject(stack)
        .edgesIgnoringSafeArea(.all)
        .accentColor(Color(red: 60.0/255.0, green: 82.0/255.0, blue: 130.0/255.0))
        .colorScheme(.light)
    }
    
    public init(interactiveSwipe: Bool = false, @ViewBuilder content: @escaping () -> Content) {
        self.interactiveSwipe = interactiveSwipe
        stack = _IOS6NavigationStack(rootView: content())
    }
}

struct IOS6NavigationView_Previews: PreviewProvider {
    static var previews: some View {
        IOS6NavigationView {
            Text("Navigation View")
        }
    }
}
