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
    
    public struct Label: View, Equatable, Identifiable {
        private let styleMakeBody: () -> AnyView
        public let id: AnyHashable
        
        public var body: some View {
            self.styleMakeBody()
        }
        
        init(_ label: @escaping () -> AnyView, id: AnyHashable) {
            self.styleMakeBody = label
            self.id = id
        }
        
        init<LL: View>(_ label: LL, id: AnyHashable) {
            self.styleMakeBody = label.makeTypeErasedBody
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
