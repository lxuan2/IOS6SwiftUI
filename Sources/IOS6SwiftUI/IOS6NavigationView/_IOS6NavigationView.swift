//
//  _IOS6NavigationView.swift
//  Demo
//
//  Created by Xuan Li on 8/13/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct _IOS6NavigationView: View {
    let interactiveSwipe: Bool
    private let debounceDistance: CGFloat = 10
    @EnvironmentObject private var stack: _IOS6NavigationStack
    
    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 0) {
                _IOS6NavigationBar(width: proxy.size.width + proxy.safeAreaInsets.leading + proxy.safeAreaInsets.trailing)
                    .zIndex(1)
                
                ZStack(alignment: .leading) {
                    _IOS6NavigationContentView(width: proxy.size.width + proxy.safeAreaInsets.leading + proxy.safeAreaInsets.trailing)
                        .allowsHitTesting(!self.stack.blocking)
                    
                    .edgesIgnoringSafeArea(.all)
                    
                    if self.interactiveSwipe {
                        Color.clear
                            .frame(width: 20 + proxy.safeAreaInsets.leading)
                            .contentShape(Rectangle())
                            .gesture(
                                DragGesture(minimumDistance: self.debounceDistance, coordinateSpace: .global)
                                    .onChanged {
                                        self.stack.updateOffset((($0.translation.width - self.debounceDistance) / proxy.size.width))
                                }
                                .onEnded { self.stack.endOffset(with: $0, in: proxy) }
                        )
                            .edgesIgnoringSafeArea([.vertical, .leading])
                    }
                }
                .background(_IOS6NavigationWallpaper())
                .zIndex(0)
            }
        }
        .environment(\._ios6NavigationStack, stack)
        .accentColor(Color(red: 60.0/255.0, green: 82.0/255.0, blue: 130.0/255.0))
        .colorScheme(.light)
        .ios6StatusBar(Color(red: 70/255, green: 100/255, blue: 133/255))
    }
}

struct _IOS6NavigationView_Previews: PreviewProvider {
    static var previews: some View {
        _IOS6NavigationView(interactiveSwipe: true)
    }
}
