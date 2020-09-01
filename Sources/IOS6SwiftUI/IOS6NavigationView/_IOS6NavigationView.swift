//
//  _IOS6NavigationView.swift
//  Demo
//
//  Created by Xuan Li on 9/1/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct _IOS6NavigationView: View {
    @Environment(\._ios6NavigationViewStyle) private var style
    @State private var links: [Link] = []
    @State private var idRecorder: Int = 0
    var master: Root
    var detail: Root
    
    var body: some View {
        let configuration = Configuration(links: links, masterRoot: master, detailRoot: detail, makeMasterBody: style.makeMasterBody, makeDetailBody: style.makeDetailBody)
        return style.makeBody(configuration: configuration)
            .environment(\._ios6NavigationIdGenerator, {
                let newId = self.idRecorder
                self.idRecorder += 1
                return newId
            })
            .onPreferenceChange(_IOS6NavigationLinkPreferenceKey.self) { items in
                let data = items.sorted { $0.id < $1.id }
                self.links = data
                self.idRecorder = data.last == nil ? 0 : (data.last!.id) + 1
        }
    }
}

extension _IOS6NavigationView {
    public typealias Root = IOS6NavigationViewStyleComponentConfiguration.Root
    public typealias Link = IOS6NavigationViewStyleComponentConfiguration.Link
    public typealias Configuration = IOS6NavigationViewStyleConfiguration
    public typealias Component = IOS6NavigationViewStyleConfiguration.Component
}
