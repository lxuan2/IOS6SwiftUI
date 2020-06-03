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
    private let stack: _IOS6NavigationStack
    
    public var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 0) {
                _IOS6NavigationBar()
                    .padding(.top, proxy.safeAreaInsets.top)
                    .zIndex(1)
                
                _IOS6NavigationContentView(interactiveSwipe: self.interactiveSwipe)
                    .zIndex(0)
            }
        }
        .background(_IOS6NavigationWallpaper())
        .environment(\._ios6NavigationStack, stack)
        .environmentObject(stack)
        .edgesIgnoringSafeArea(.all)
        .accentColor(Color(red: 68.0/255.0, green: 90.0/255.0, blue: 140.0/255.0))
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
