//
//  IOS6StackNavigationViewStyle.swift
//  test
//
//  Created by Xuan Li on 8/19/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

public struct IOS6StackNavigationViewStyle<NavigationConfiguration: IOS6NavigationConfiguration>: IOS6NavigationViewStyle {
    private let _configuration: NavigationConfiguration
    
    public init(configuration: NavigationConfiguration) {
        self._configuration = configuration
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        ScrollView([]) {
            configuration.master(links: configuration.links)
                .accentColor(Color(red: 60.0/255.0, green: 82.0/255.0, blue: 130.0/255.0))
                .colorScheme(.light)
        }
        .edgesIgnoringSafeArea(.all)
        .ios6StatusBar(Color(red: 70/255, green: 100/255, blue: 133/255))
    }
    
    public func makeMasterBody(configuration: ComponentConfiguration) -> some View {
        ZStack {
            VStack(spacing: 0) {
                _configuration.navigationBarBackground.frame(height: 44)
                _configuration.contentBackground
            }.edgesIgnoringSafeArea([.horizontal, .bottom])
            
            GeometryReader { proxy in
                _IOS6StackNavigationView(root: configuration.root,
                                         links: configuration.links,
                                         barData: buildNavigationBarData(titles: configuration.titles),
                                         dismiss: configuration.links.last?.dismiss,
                                         configuration: self._configuration,
                                         proxy: proxy)
            }
        }
    }
}

extension IOS6StackNavigationViewStyle where NavigationConfiguration == IOS6BlueNavigationConfiguration {
    public init() {
        self._configuration = IOS6BlueNavigationConfiguration()
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
