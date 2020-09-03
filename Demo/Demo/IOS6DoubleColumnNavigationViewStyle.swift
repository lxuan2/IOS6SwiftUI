//
//  IOS6DoubleColumnNavigationViewStyle.swift
//  Demo
//
//  Created by Xuan Li on 9/1/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI
import IOS6SwiftUI

public struct IOS6DoubleColumnNavigationViewStyle: IOS6NavigationViewStyle {
    
    public init() {}
    
    public func makeBody(configuration: Configuration) -> some View {
        let (masterLinks, detailLinks) = configuration.getSeparatedLinks()
        return GeometryReader { proxy in
            HStack(spacing: 1) {
                ScrollView([]) {
                    configuration.master(links: masterLinks)
                }
                .frame(width: min(350, proxy.size.width))
                .edgesIgnoringSafeArea(.all)
                
                
                ScrollView([]) {
                    configuration.detail(links: detailLinks)
                }
                .edgesIgnoringSafeArea(.all)
            }
        }
        .accentColor(Color(red: 60.0/255.0, green: 82.0/255.0, blue: 130.0/255.0))
        .colorScheme(.light)
        .ios6RootBackground(Color.black.edgesIgnoringSafeArea(.all))
        .ios6StatusBar(Color.black)
    }
    
    public func makeMasterBody(configuration: ComponentConfiguration) -> some View {
        GeometryReader { proxy in
            ZStack {
                _IOS6DoubleColumnMasterWallpaper()
                
                buildIOS6StackNavigationView(configuration: configuration, proxy: proxy)
            }
        }
    }
    
    public func makeDetailBody(configuration: ComponentConfiguration) -> some View {
        GeometryReader { proxy in
            ZStack {
                _IOS6DoubleColumnDetailWallpaper()
                
                buildIOS6StackNavigationView(configuration: configuration, proxy: proxy)
            }
        }
    }
}
