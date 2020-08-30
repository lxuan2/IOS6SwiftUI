//
//  _IOS6NavigationContentView.swift
//  test
//
//  Created by Xuan Li on 8/23/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct _IOS6NavigationContentView: View {
    let root: Root
    let links: [Link]
    let width: CGFloat
    @Binding var offsets: [Int: CGFloat]
    @State private var rootOffset: CGFloat = 0
    
    var body: some View {
        ZStack {
            root
                .frame(width: width)
                .offset(x: rootOffset , y: 0)
            
            ForEach(links,content: linkItem)
        }
    }
    
    func linkItem(_ link: Link) -> some View {
        let id = link.id
        let idIndex = self.links.firstIndex(of: link)
        return link
            .frame(width: self.width)
            .offset(x: self.offsets[link.id] ?? self.width, y: 0)
            .onAppear {
                withAnimation(Animation.easeInOut(duration: 0.4).delay(0.2)) {
                    self.offsets[link.id] = 0
                    if let index = self.links.firstIndex(of: link), index > 0 {
                        self.offsets[self.links[index-1].id] = -self.width
                        if index > 1 {
                            self.offsets[self.links[index-2].id] = -self.width*2
                        } else {
                            self.rootOffset = -self.width*2
                        }
                    } else {
                        self.rootOffset = -self.width
                    }
                }
        }.onDisappear {
            self.offsets.removeValue(forKey: id)
            if let index = idIndex, index > 0 {
                self.offsets[self.links[index-1].id] = 0
                if index > 1 {
                    self.offsets[self.links[index-2].id] = -self.width
                } else {
                    self.rootOffset = -self.width
                }
            } else {
                self.rootOffset = 0
            }
        }
    }
    
    typealias Root = IOS6NavigationViewStyleComponentConfiguration.Root
    typealias Link = IOS6NavigationViewStyleComponentConfiguration.Link
}
