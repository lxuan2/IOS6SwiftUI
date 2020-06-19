//
//  _IOS6TabItem.swift
//  IOS6
//
//  Created by Xuan Li on 6/16/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct _IOS6TabItemKey: PreferenceKey {
    static var defaultValue: [_IOS6TabItemData] = []
    
    static func reduce(value: inout [_IOS6TabItemData], nextValue: () -> [_IOS6TabItemData]) {
        value.append(contentsOf: nextValue())
    }
}

struct _IOS6TabItemData: Equatable {
    let content: AnyView
    let label: AnyView
    
    init<Content: View, Label: View>(content: Content, label: Label) {
        self.content = AnyView(content)
        self.label = AnyView(label)
    }
    
    static func == (lhs: _IOS6TabItemData, rhs: _IOS6TabItemData) -> Bool {
        true
    }
}

extension View {
    public func ios6TabItem<V>(tag: Int = 0, @ViewBuilder _ label: () -> V) -> some View where V : View {
        preference(key: _IOS6TabItemKey.self, value: [_IOS6TabItemData(content: self, label: label())])
    }
}
