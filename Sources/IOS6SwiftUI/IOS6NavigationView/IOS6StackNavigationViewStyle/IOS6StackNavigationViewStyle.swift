//
//  IOS6StackNavigationViewStyle.swift
//  test
//
//  Created by Xuan Li on 8/19/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

public struct IOS6StackNavigationViewStyle<Appearance: IOS6NavigationAppearance>: IOS6NavigationViewStyle {
    private let appearance: Appearance
    
    public init(_ appearance: Appearance) {
        self.appearance = appearance
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        ScrollView([]) {
            configuration.master(links: configuration.links)
                .accentColor(appearance.accentColor)
                .colorScheme(.light)
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    public func makeMasterBody(configuration: ComponentConfiguration) -> some View {
        ZStack {
            VStack(spacing: 0) {
                appearance.navigationBarBackground.frame(height: 44).zIndex(1)
                appearance.contentBackground
            }.edgesIgnoringSafeArea([.horizontal, .bottom])
            
            GeometryReader { proxy in
                _IOS6StackNavigationView(root: configuration.root,
                                         links: configuration.links,
                                         barData: buildNavigationBarData(titles: configuration.titles),
                                         dismiss: configuration.links.last?.dismiss,
                                         appearance: self.appearance,
                                         proxy: proxy)
            }
        }
    }
}

extension IOS6StackNavigationViewStyle where Appearance == IOS6BlueNavigationAppearance {
    public init() {
        self.appearance = IOS6BlueNavigationAppearance()
    }
}

struct IgnoreLayoutOffset: GeometryEffect {
    var x: CGFloat = 0
    
    var animatableData: CGFloat {
        get { x }
        set { x = newValue }
    }
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        return ProjectionTransform(CGAffineTransform(translationX: x, y: 0))
    }
}
