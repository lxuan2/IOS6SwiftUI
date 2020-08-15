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
    
    public let labels: [IOS6TabBarStyleConfiguration.Label]
    
    public struct Label: Equatable, Identifiable {
        public let icon: Image
        public let title: Text
        public let insets: EdgeInsets
        public let id: AnyHashable
        
        init(_ title: Text, _ icon: Image, insets: EdgeInsets, id: AnyHashable) {
            self.title = title
            self.icon = icon
            self.insets = insets
            self.id = id
        }
    }
}
