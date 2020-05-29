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
    var interactiveSwipe: Bool
    
    private let stack: IOS6NavigationStack
    
    public var body: some View {
        VStack(spacing: 0) {
            IOS6NavigationBar()
                .zIndex(1)
            
            IOS6NavigationContentView(interactiveSwipe: interactiveSwipe)
                .zIndex(0)
                .edgesIgnoringSafeArea([.bottom])
        }
        .background(IOS6NavigationWallpaper())
        .environment(\.ios6NavigationStack, stack)
        .environmentObject(stack)
        .accentColor(Color(red: 68.0/255.0, green: 90.0/255.0, blue: 140.0/255.0))
        .colorScheme(.light)
    }
    
    public init(interactiveSwipe: Bool = false, @ViewBuilder content: @escaping () -> Content) {
        self.interactiveSwipe = interactiveSwipe
        stack = IOS6NavigationStack(rootView: content())
    }
}

struct IOS6NavigationView_Previews: PreviewProvider {
    static var previews: some View {
        IOS6NavigationView {
            Text("Navigation View")
        }
    }
}
