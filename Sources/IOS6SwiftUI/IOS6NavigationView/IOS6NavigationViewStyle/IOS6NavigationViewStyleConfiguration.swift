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
        @State private var titles: [String?] = []
        private let root: Root
        private var links: [Link]
        private let makeBody: (ComponentConfiguration) -> AnyView
        
        init(root: Root, links: [Link], content: @escaping (ComponentConfiguration) -> AnyView) {
            self.root = root
            self.makeBody = content
            self.links = links
        }
        
        /// The type of view representing the body of this view.
        ///
        /// When you create a custom view, Swift infers this type from your
        /// implementation of the required `body` property.
        public var body: some View {
            makeBody(.init(root: root, links: links, titles: titles))
                
            .onPreferenceChange(_IOS6NavigationTitleKey.self) { items in
                self.titles = items
            }
        }
    }
    
    init(links: [Link], masterRoot: Root, detailRoot: Root, makeMasterBody: @escaping (ComponentConfiguration) -> AnyView, makeDetailBody: @escaping (ComponentConfiguration) -> AnyView) {
        self.links = links
        self.masterRoot = masterRoot
        self.detailRoot = detailRoot
        self.makeMasterBody = makeMasterBody
        self.makeDetailBody = makeDetailBody
    }
    
    public func master(links: [Link]) -> Component {
        Component(root: masterRoot, links: links, content: makeMasterBody)
    }
    
    public func detail(links: [Link]) -> Component {
        Component(root: detailRoot, links: links, content: makeDetailBody)
    }
    
    public let links: [Link]
    
    @inlinable public func getSeparatedLinks() -> ([Link], [Link]) {
        var masterLinks: [Link] = []
        var detailLinks: [Link] = []
        for link in links {
            switch link.type {
            case .master:
                masterLinks.append(link)
            case .detail:
                detailLinks.append(link)
            }
        }
        return (masterLinks, detailLinks)
    }
    
    private var masterRoot: Root
    private var detailRoot: Root
    private var makeMasterBody: (ComponentConfiguration) -> AnyView
    private var makeDetailBody: (ComponentConfiguration) -> AnyView
    
    public typealias Link = IOS6NavigationViewStyleComponentConfiguration.Link
    typealias Root = IOS6NavigationViewStyleComponentConfiguration.Root
    typealias ComponentConfiguration = IOS6NavigationViewStyleComponentConfiguration
    typealias LinkType = IOS6NavigationViewStyleComponentConfiguration.LinkType
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
