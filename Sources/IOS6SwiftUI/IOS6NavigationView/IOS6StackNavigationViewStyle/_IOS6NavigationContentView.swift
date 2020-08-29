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
    
    var body: some View {
        var offsets: [Int: CGFloat] = [:]
        links.forEach { offsets[$0.id] = -width*2 }
        if !links.isEmpty {
            offsets[links[links.count - 1].id] = 0
            if links.count > 1 {
                offsets[links[links.count - 2].id] = -width
            }
        }
        return ZStack {
            root
                
                .frame(width: width)
                .offset(x: links.count == 0 ? 0 : links.count == 1 ? -width : -width*2 , y: 0)
            
            ForEach(links) { link in
                link
                    
                    .frame(width: self.width)
                    .offset(x: offsets[link.id]!, y: 0)
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .identity))
            }
        }
    }
    
    typealias Root = IOS6NavigationViewStyleComponentConfiguration.Root
    typealias Link = IOS6NavigationViewStyleComponentConfiguration.Link
}
