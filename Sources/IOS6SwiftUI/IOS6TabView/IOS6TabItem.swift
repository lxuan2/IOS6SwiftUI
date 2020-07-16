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
            if globalId != id as AnyHashable {
                Spacer()
            } else {
                content
            }
        }.preference(key: _IOS6TabItemKey.self, value: [IOS6TabBarStyleConfiguration.Label(label, id: id)])
    }
    
    init(label: @escaping () -> AnyView) {
        self.label = label
    }
}

extension View {
    /// Sets the IOS6 tab bar item associated with this view.
    /// - Parameters:
    ///   - tag: a tag to indicate order. ( Currently not implemented. )
    ///   - label: a label that represent the current view
    /// - Returns: some View
    public func ios6TabItem<V>(tag: Int = 0, @ViewBuilder _ label: @escaping () -> V) -> some View where V : View {
        modifier(_IOS6TabItem(label: { AnyView(label()) }))
    }
}

struct _IOS6TabItemKey: PreferenceKey {
    static var defaultValue: [IOS6TabBarStyleConfiguration.Label] = []
    
    static func reduce(value: inout [IOS6TabBarStyleConfiguration.Label], nextValue: () -> [IOS6TabBarStyleConfiguration.Label]) {
        value.append(contentsOf: nextValue())
    }
}

struct _IOS6TabKey: EnvironmentKey {
    static var defaultValue: AnyHashable? = nil
}

extension EnvironmentValues {
    var _ios6Tab: AnyHashable? {
        get { return self[_IOS6TabKey.self] }
        set { self[_IOS6TabKey.self] = newValue }
    }
}
