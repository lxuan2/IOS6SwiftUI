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
    var interactiveSwipe: Bool
    
    public var body: some View {
        VStack(spacing: 0) {
            IOS6NavigationBar()
                .zIndex(1)
            
            IOS6NavigationContentView(interactiveSwipe: interactiveSwipe)
                .zIndex(0)
                .edgesIgnoringSafeArea([.bottom])
        }
        .background(IOS6NavigationWallpaper())
        .environmentObject(viewStack ?? IOS6NavigationStack(rootView: EmptyView()))
        .colorScheme(.light)
    }
    
    public init(interactiveSwipe: Bool = false, @ViewBuilder content: @escaping () -> Content) {
        self.interactiveSwipe = interactiveSwipe
        viewStack = IOS6NavigationStack(rootView: content())
        
    }
}

struct IOS6NavigationView_Previews: PreviewProvider {
    static var previews: some View {
        IOS6NavigationView {
            Text("Navigation View")
        }
    }
}
