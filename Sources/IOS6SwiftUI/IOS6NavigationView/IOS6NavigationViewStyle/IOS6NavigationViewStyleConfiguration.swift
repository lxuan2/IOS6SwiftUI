//
//  IOS6NavigationViewStyleConfiguration.swift
//  test
//
//  Created by Xuan Li on 8/19/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI
import Combine

public struct IOS6NavigationViewStyleConfiguration {
    
    /// A type-erased component of a `IOS6NavigationView`.
    public struct Component: View {
        @State private var links: [Link] = []
        @State private var titles: [String?] = []
        @State private var idRecorder: Int = 0
        private let root: Root
        private let content: (ComponentConfiguration) -> AnyView
        private let type: LinkType
        
        init(root: Root, content: @escaping (ComponentConfiguration) -> AnyView, type: LinkType) {
            self.root = root
            self.content = content
            self.type = type
        }
        
        /// The type of view representing the body of this view.
        ///
        /// When you create a custom view, Swift infers this type from your
        /// implementation of the required `body` property.
        public var body: some View {
            content(.init(root: root, links: links, titles: titles))
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
            .onPreferenceChange(_IOS6NavigationTitleKey.self) { items in
                self.titles = items
            }
        }
        
        public typealias Link = IOS6NavigationViewStyleComponentConfiguration.Link
        public typealias Root = IOS6NavigationViewStyleComponentConfiguration.Root
        public typealias ComponentConfiguration = IOS6NavigationViewStyleComponentConfiguration
        public typealias LinkType = IOS6NavigationViewStyleComponentConfiguration.LinkType
    }
    
    init(sideBar: Component, master: Component, detail: Component) {
        self.sideBar = sideBar
        self.master = master
        self.detail = detail
    }
    
    var sideBar: Component
    var master: Component
    var detail: Component
}

struct _IOS6NavigationIdGeneratorEnvironmentKey: EnvironmentKey {
    static let defaultValue: (() -> Int)? = nil
}

extension EnvironmentValues {
    var _ios6NavigationIdGenerator: (() -> Int)?  {
        get {
            return self[_IOS6NavigationIdGeneratorEnvironmentKey.self]
        }
        set {
            self[_IOS6NavigationIdGeneratorEnvironmentKey.self] = newValue
        }
    }
}

//var newLinks = self.links
//// remove old
//newLinks.removeAll(where: { value in !data.contains(where: { $0.id == value.id }) })
//for i in data {
//    if let index = newLinks.firstIndex(where: { $0.id == i.id }) {
//        // update self
//        newLinks[index] = i
//    } else {
//        // add to self
//        if self.type == i.type {
//            newLinks.append(i)
//        }
//        // add to other
//
//    }
//}
//self.links = newLinks
