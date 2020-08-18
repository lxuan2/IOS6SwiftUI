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
        private let _icon: () -> AnyView
        private let _title: () -> AnyView
        public let id: AnyHashable
        
        public var icon: some View {
            self._icon()
        }
        
        public var title: some View {
            self._title()
        }
        
        init<Title: View, Icon: View>(_ title: Title, _ icon: Icon, id: AnyHashable) {
            self._title = title.makeTypeErasedBody
            self._icon = icon.makeTypeErasedBody
            self.id = id
        }
        
        public static func == (lhs: IOS6TabBarStyleConfiguration.Label, rhs: IOS6TabBarStyleConfiguration.Label) -> Bool {
            lhs.id == rhs.id
        }
    }
}

fileprivate extension View {
    func makeTypeErasedBody() -> AnyView {
        AnyView(self)
    }
}
