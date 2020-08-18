//
//  IOS6TabBarStyleConfiguration.swift
//  IOS6
//
//  Created by Xuan Li on 7/15/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

public struct IOS6TabBarStyleConfiguration {
    public var selection: Binding<AnyHashable?>
    
    public let items: [IOS6TabBarStyleConfiguration.Item]
    
    public func setTabItem(_ item: Item) {
        selection.wrappedValue = item.tag
    }
    
    public func isSelected(_ item: Item) -> Bool {
        selection.wrappedValue == item.tag
    }
    
    public struct Item: Equatable, Identifiable {
        public let icon: Icon
        public let title: Title
        public let id: AnyHashable
        let tag: AnyHashable
        
        init<TitleType: View, IconType: View>(_ title: TitleType, _ icon: IconType, tag: AnyHashable, id: AnyHashable) {
            self.title = Title(title: title)
            self.icon = Icon(icon: icon)
            self.tag = tag
            self.id = id
        }
        
        public static func == (lhs: IOS6TabBarStyleConfiguration.Item, rhs: IOS6TabBarStyleConfiguration.Item) -> Bool {
            lhs.id == rhs.id && lhs.tag == rhs.tag
        }
        
        public struct Icon: View {
            private let icon: AnyView
            
            public var body: some View {
                icon
            }
            
            init<IconType: View>(icon: IconType) {
                self.icon = AnyView(icon)
            }
        }
        
        public struct Title: View {
            private let title: AnyView
            
            public var body: some View {
                title
            }
            
            init<TitleType: View>(title: TitleType) {
                self.title = AnyView(title)
            }
        }
    }
}
