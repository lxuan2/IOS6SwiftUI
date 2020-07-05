//
//  IOS6TabItem.swift
//  IOS6
//
//  Created by Xuan Li on 6/21/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct _IOS6TabItem: ViewModifier {
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
        modifier(_IOS6TabItem(label: { AnyView(label()) }))
    }
}

struct _IOS6TabItemData: Equatable, Identifiable {
    let label: () -> AnyView
    let id: UUID
    
    init(label: @escaping () -> AnyView, id: UUID) {
        self.id = id
        self.label = label
    }
    
    static func == (lhs: _IOS6TabItemData, rhs: _IOS6TabItemData) -> Bool {
        lhs.id == rhs.id
    }
}

struct _IOS6TabItemKey: PreferenceKey {
    static var defaultValue: [_IOS6TabItemData] = []
    
    static func reduce(value: inout [_IOS6TabItemData], nextValue: () -> [_IOS6TabItemData]) {
        value.append(contentsOf: nextValue())
    }
}

struct _IOS6TabKey: EnvironmentKey {
    static var defaultValue: UUID? = nil
}

extension EnvironmentValues {
    var _ios6Tab: UUID? {
        get { return self[_IOS6TabKey.self] }
        set { self[_IOS6TabKey.self] = newValue }
    }
}
