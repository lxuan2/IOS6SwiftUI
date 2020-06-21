//
//  IOS6TabItem.swift
//  IOS6
//
//  Created by Xuan Li on 6/21/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct IOS6TabItem: ViewModifier {
    @State private var id: UUID = UUID()
    @Environment(\._ios6Tab) var globalId
    let label: () -> AnyView
    
    func body(content: Content) -> some View {
        Group {
            if globalId != nil && globalId! != id {
                Spacer()
            } else {
                content
            }
        }.preference(key: _IOS6TabItemKey.self, value: [_IOS6TabItemData(label: self.label, id: self.id)])
    }
    
    init(label: @escaping () -> AnyView) {
        self.label = label
    }
}

extension View {
    public func ios6TabItem<V>(tag: Int = 0, @ViewBuilder _ label: @escaping () -> V) -> some View where V : View {
        modifier(IOS6TabItem(label: { AnyView(label()) }))
    }
}
