//
//  IOS6DoubleColumnNavigationViewStyle.swift
//  Demo
//
//  Created by Xuan Li on 9/1/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

public struct IOS6DoubleColumnNavigationViewStyle<Appearance: IOS6NavigationAppearance>: IOS6NavigationViewStyle {
    private let appearance: Appearance
    
    public init(_ appearance: Appearance) {
        self.appearance = appearance
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        _IOS6DoubleColumnNavigationView(appearance: appearance, configuration: configuration)
    }
    
    public func makeMasterBody(configuration: ComponentConfiguration) -> some View {
        GeometryReader { proxy in
            ZStack {
                VStack(spacing: 0) {
                    self.appearance.navigationBarBackground.frame(height: 44).zIndex(1)
                    self.appearance.masterBackground
                }.edgesIgnoringSafeArea([.horizontal, .bottom])
                
                buildIOS6StackNavigationView(configuration: configuration, appearance: self.appearance, proxy: proxy)
            }
        }
    }
    
    public func makeDetailBody(configuration: ComponentConfiguration) -> some View {
        GeometryReader { proxy in
            ZStack {
                VStack(spacing: 0) {
                    self.appearance.navigationBarBackground.frame(height: 44).zIndex(1)
                    self.appearance.detailBackground
                }.edgesIgnoringSafeArea([.horizontal, .bottom])
                
                buildIOS6StackNavigationView(configuration: configuration, appearance: self.appearance, proxy: proxy)
            }
        }
    }
}

extension IOS6DoubleColumnNavigationViewStyle where Appearance == IOS6GrayNavigationAppearance {
    public init() {
        self.appearance = IOS6GrayNavigationAppearance()
    }
}
