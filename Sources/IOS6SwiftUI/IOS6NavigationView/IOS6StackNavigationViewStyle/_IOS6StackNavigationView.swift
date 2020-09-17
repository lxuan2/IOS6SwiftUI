//
//  _IOS6StackNavigationView.swift
//  Demo
//
//  Created by Xuan Li on 9/3/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct _IOS6StackNavigationView<Appearance: IOS6NavigationAppearance>: View {
    @State private var offsets: [Int: CGFloat] = [:]
    @State private var offsetAmount: CGFloat = 0
    @State private var additionalAmount: CGFloat = 0
    let root: Root
    let links: [Link]
    let barData: [_IOS6NavigationBarData]
    let dismiss: (() -> Void)?
    let appearance: Appearance
    let proxy: GeometryProxy
    
    var body: some View {
        VStack(spacing: 0) {
            _IOS6NavigationBar(data: barData, width: proxy.size.width, offset: (offsets.count==links.count ? 0 : proxy.size.width) + offsetAmount, dismiss: { self.dismissFunc() }, appearance: appearance)
            
            ZStack(alignment: .leading) {
                _IOS6StackNavigationContentView(root: root, links: links, width: proxy.size.width + proxy.safeAreaInsets.leading + proxy.safeAreaInsets.trailing, contentWidth: proxy.size.width, offsets: $offsets)
                    .modifier(IgnoreLayoutOffset(x: offsetAmount + additionalAmount).ignoredByLayout())
                if !links.isEmpty {
                    Color.clear
                        .contentShape(Rectangle())
                        .gesture(
                            DragGesture(minimumDistance: 10, coordinateSpace: .global)
                                .onChanged {
                                    self.offsetAmount = max(0, $0.translation.width - 10)
                            }
                            .onEnded {
                                let half = self.proxy.size.width / 2
                                if $0.predictedEndTranslation.width - 10 > half {
                                    self.dismissFunc(percent: Double(1 - ($0.translation.width - 10) / self.proxy.size.width))
                                } else {
                                    withAnimation(.easeInOut(duration: resetTime)) {
                                        self.offsetAmount = 0
                                    }
                                }
                            }
                    )
                        .frame(width: 20 + proxy.safeAreaInsets.leading)
                        .edgesIgnoringSafeArea(.horizontal)
                }
            }
        }
    }
    
    func dismissFunc(percent: Double = 1) {
        withAnimation(.easeInOut(duration: transTime * percent)) {
            self.offsetAmount = self.proxy.size.width
        }
        self.additionalAmount = self.proxy.safeAreaInsets.leading + self.proxy.safeAreaInsets.trailing
        self.dismiss?()
        DispatchQueue.main.asyncAfter(deadline: .now() + transTime + delay) {
            self.offsetAmount = 0
            self.additionalAmount = 0
        }
    }
    
    typealias Root = IOS6NavigationViewStyleComponentConfiguration.Root
    typealias Link =  IOS6NavigationViewStyleComponentConfiguration.Link
}

let transTime: Double = 0.35
let resetTime: Double = 0.2
let delay: Double = 0.1

public func buildIOS6StackNavigationView<Appearance: IOS6NavigationAppearance>(configuration: IOS6NavigationViewStyleComponentConfiguration, appearance: Appearance, proxy: GeometryProxy) -> some View {
    _IOS6StackNavigationView(root: configuration.root,
                             links: configuration.links,
                             barData: buildNavigationBarData(titles: configuration.titles),
                             dismiss: configuration.links.last?.dismiss,
                             appearance: appearance,
                             proxy: proxy)
}
