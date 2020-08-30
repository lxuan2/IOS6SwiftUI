//
//  IOS6StackNavigationViewStyle.swift
//  test
//
//  Created by Xuan Li on 8/19/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

public struct IOS6StackNavigationViewStyle: IOS6NavigationViewStyle {
    public func makeBody(configuration: Configuration) -> some View {
        configuration.master
    }
    
    public func makeMasterBody(configuration: ComponentConfiguration) -> some View {
        GeometryReader { proxy in
            ZStack {
                _IOS6NavigationWallpaper()
                
                IOS6StackNavigationViewStyle.buildIOS6StackNavigationView(configuration: configuration, proxy: proxy)
                    .accentColor(Color(red: 60.0/255.0, green: 82.0/255.0, blue: 130.0/255.0))
                    .colorScheme(.light)
            }
        }.ios6StatusBar(Color(red: 70/255, green: 100/255, blue: 133/255))
    }
    
    static func buildIOS6StackNavigationView(configuration: ComponentConfiguration, proxy: GeometryProxy) -> some View {
        IOS6StackNavigationView(root: configuration.root, links: configuration.links, barData: _IOS6NavigationBar.buildNavigationBarData(titles: configuration.titles), dismiss: configuration.links.last?.dismiss, proxy: proxy)
    }
    
    struct IOS6StackNavigationView: View {
        @State private var offsetAmount: CGFloat = 0
        let root: Root
        let links: [Link]
        let barData: [_IOS6NavigationBar.Data]
        let dismiss: (() -> Void)?
        let proxy: GeometryProxy
        @State private var offsets: [Int: CGFloat] = [:]
        
        var body: some View {
            ZStack(alignment: .leading) {
                VStack(spacing: 0) {
                    _IOS6NavigationBar(data: barData, width: proxy.size.width, offset: (offsets.count==links.count ? 0 : proxy.size.width) + offsetAmount, dismiss: { self.dismissFunc() })
                    
                    _IOS6NavigationContentView(root: root, links: links, width: proxy.size.width, offsets: $offsets)
                        .modifier(IgnoreLayoutOffset(x: offsetAmount).ignoredByLayout())
                }
                
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
                                withAnimation {
                                    self.offsetAmount = 0
                                }
                            }
                        }
                )
                    .frame(width: 20 + proxy.safeAreaInsets.leading)
            }
        }
        
        func dismissFunc(percent: Double = 1) {
            withAnimation(.easeInOut(duration: IOS6StackNavigationViewStyle.IOS6StackNavigationView.self.transTime * percent)) {
                self.offsetAmount = self.proxy.size.width
            }
            self.dismiss?()
            DispatchQueue.main.asyncAfter(deadline: .now() + IOS6StackNavigationViewStyle.IOS6StackNavigationView.self.transTime + IOS6StackNavigationViewStyle.IOS6StackNavigationView.self.delay) {
                self.offsetAmount = 0
            }
        }
        
        typealias Root = IOS6NavigationViewStyleComponentConfiguration.Root
        typealias Link =  IOS6NavigationViewStyleComponentConfiguration.Link
        static let transTime: Double = 0.4
        static let delay: Double = 0.1
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
}

