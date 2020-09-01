//
//  IOS6NavigationViewStyleComponentConfiguration.swift
//  test
//
//  Created by Xuan Li on 8/19/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

public struct IOS6NavigationViewStyleComponentConfiguration {
    
    public enum LinkType {
        case master
        case detail
    }
    
    struct _LinkTypeEnvironmentKey: EnvironmentKey {
        static let defaultValue: LinkType = .master
    }
    
    public struct Link : View, Identifiable, Equatable, Hashable {
        private let link: AnyView
        private let _id: Binding<Int?>
        private let _type: LinkType
        
        init<LinkViewType: View>(_ link: LinkViewType, type: LinkType, id: Binding<Int?>) {
            self.link = AnyView(link)
            self._type = type
            self._id = id
        }
        
        /// The type of view representing the body of this view.
        ///
        /// When you create a custom view, Swift infers this type from your
        /// implementation of the required `body` property.
        public var body: some View {
            Color.clear
                .edgesIgnoringSafeArea(.all)
                .overlay(
                    link
                        .transformPreference(_IOS6NavigationTitleKey.self) { titles in
                            titles = titles.isEmpty ? [nil] : [titles.last!]
                })
            
        }
        
        public static func == (lhs: Link, rhs: Link) -> Bool {
            lhs.id == rhs.id && lhs.type == rhs.type
        }
        
        public func hash(into hasher: inout Hasher) {
            hasher.combine(_id.wrappedValue)
            hasher.combine(type)
        }
        
        public var id: Int {
            _id.wrappedValue ?? Int.max
        }
        
        public var type: LinkType {
            _type
        }
        
        public func dismiss() {
            _id.wrappedValue = nil
        }
    }
    
    public struct Root : View {
        private let root: AnyView
        
        init<RootType: View>(_ root: RootType) {
            self.root = AnyView(root)
        }
        
        /// The type of view representing the body of this view.
        ///
        /// When you create a custom view, Swift infers this type from your
        /// implementation of the required `body` property.
        public var body: some View {
            Color.clear
                .edgesIgnoringSafeArea(.all)
                .overlay(
                    root
                        .transformPreference(_IOS6NavigationTitleKey.self) { titles in
                            titles = titles.isEmpty ? [nil] : [titles.last!]
                    }
            )
        }
    }
    
    public let root: Root
    public let links: [Link]
    public let titles: [String?]
    
    init(root: Root, links: [Link], titles: [String?]) {
        self.root = root
        self.links = links
        if (links.count+1) == titles.count {
            self.titles = titles
        } else if (links.count+1) > titles.count {
            self.titles = titles + Array(repeating: nil, count: (links.count+1) - titles.count)
        } else {
            self.titles = Array(titles[...links.count])
        }
    }
}



extension EnvironmentValues {
    var _ios6NavigationLinkType: IOS6NavigationViewStyleComponentConfiguration.LinkType {
        get {
            return self[IOS6NavigationViewStyleComponentConfiguration._LinkTypeEnvironmentKey.self]
        }
        set {
            self[IOS6NavigationViewStyleComponentConfiguration._LinkTypeEnvironmentKey.self] = newValue
        }
    }
}
