//
//  IOS6NavigationView.swift
//  animation
//
//  Created by Xuan Li on 1/15/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

/// A view for presenting a stack of views representing a visible path in a
/// navigation hierarchy in IOS6 style.
public struct IOS6NavigationView<Content: View>: View {
    private let interactiveSwipe: Bool
    private let content: Content
    
    public var body: some View {
        _IOS6NavigationView(interactiveSwipe: interactiveSwipe)
            .environmentObject(_IOS6NavigationStack(rootView: content))
    }
    
    /// An initializer
    /// - Parameters:
    ///   - interactiveSwipe: a `Bool` value indicate whether interactive swipe is allowed
    ///   - content: navigation root view
    public init(interactiveSwipe: Bool = true, @ViewBuilder content: @escaping () -> Content) {
        self.interactiveSwipe = interactiveSwipe
        self.content = content()
    }
}

struct IOS6NavigationView_Previews: PreviewProvider {
    static var previews: some View {
        IOS6NavigationView {
            Text("Navigation View")
        }
    }
}
