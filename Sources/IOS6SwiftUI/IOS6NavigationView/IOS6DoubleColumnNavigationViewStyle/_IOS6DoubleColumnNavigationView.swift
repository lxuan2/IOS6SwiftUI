//
//  _IOS6DoubleColumnNavigationView.swift
//  Demo
//
//  Created by Xuan Li on 9/4/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct _IOS6DoubleColumnNavigationView<Appearance: IOS6NavigationAppearance>: View {
    let appearance: Appearance
    let configuration: IOS6NavigationViewStyleConfiguration
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    var body: some View {
        let (masterLinks, detailLinks) = configuration.getSeparatedLinks()
        let regular = self.horizontalSizeClass == .regular
        return GeometryReader { proxy in
            HStack(spacing: 1) {
                ScrollView([]) {
                    self.configuration.master(links: regular ? masterLinks : self.configuration.links)
                }
                .frame(width: regular ? min(350, proxy.size.width) : nil)
                .edgesIgnoringSafeArea(.all)
                
                if regular {
                    ScrollView([]) {
                        self.configuration.detail(links: detailLinks)
                    }
                    .edgesIgnoringSafeArea(.all)
                }
            }
        }
        .accentColor(Color(red: 60.0/255.0, green: 82.0/255.0, blue: 130.0/255.0))
        .colorScheme(.light)
        .ios6RootBackground(Color.black.edgesIgnoringSafeArea(.all))
        .ios6StatusBar(Color.black)
    }
}
