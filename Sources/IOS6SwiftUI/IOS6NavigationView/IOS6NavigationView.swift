//
//  IOS6NavigationView.swift
//  test
//
//  Created by Xuan Li on 8/19/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

public struct IOS6NavigationView<Content: View>: View {
    var master: Root
    var detail: Root
    
    public var body: some View {
        ScrollView([]) {
            _IOS6NavigationView(master: master, detail: detail)
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    public typealias Root = IOS6NavigationViewStyleComponentConfiguration.Root
}

public extension IOS6NavigationView where Content == TupleView<(Root,Root)> {
    init(@IOS6NavigationViewBuilder content: () -> Content ) {
        let views = content().value
        self.master = views.0
        self.detail = views.1
    }
}

public extension IOS6NavigationView {
    init(@IOS6NavigationViewBuilder content: () -> Content ) {
        self.master = Root(content())
        self.detail = Root(EmptyView())
    }
}
