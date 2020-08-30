//
//  IOS6NavigationView.swift
//  test
//
//  Created by Xuan Li on 8/19/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

public struct IOS6NavigationView<Content: View>: View {
    @Environment(\._ios6NavigationViewStyle) private var style
    let sideBar: Root
    let master: Root
    let detail: Root
    
    public var body: some View {
        let sideBarComponent = Component(root: sideBar, content: style.makeSideBarBody, type: .sideBar)
        let masterComponent = Component(root: master, content: style.makeMasterBody, type: .master)
        let detailComponent = Component(root: detail, content: style.makeDetailBody, type: .detail)
        let configuration = Configuration(sideBar: sideBarComponent, master: masterComponent, detail: detailComponent)
        return ScrollView([]) {
            style.makeBody(configuration: configuration)
        }.edgesIgnoringSafeArea(.all)
    }
}

public extension IOS6NavigationView where Content == TupleView<(Root,Root,Root)> {
    init(@IOS6NavigationViewBuilder content: () -> Content ) {
        let views = content().value
        self.sideBar = views.0
        self.master = views.1
        self.detail = views.2
    }
}

public extension IOS6NavigationView {
    init(@IOS6NavigationViewBuilder content: () -> Content ) {
        self.sideBar = Root(EmptyView())
        self.master = Root(content())
        self.detail = Root(EmptyView())
    }
}

extension IOS6NavigationView {
    public typealias Root = IOS6NavigationViewStyleComponentConfiguration.Root
    public typealias Configuration = IOS6NavigationViewStyleConfiguration
    public typealias Component = IOS6NavigationViewStyleConfiguration.Component
}
