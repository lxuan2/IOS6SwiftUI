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
    @State private var loaded: Bool = false
    @Environment(\._ios6Tab) var globalId
    @Environment(\._ios6Tag) var tag
    let label: () -> AnyView
    
    func body(content: Content) -> some View {
        let enabled = globalId == (tag ?? id as AnyHashable)
        return Group {
            if self.loaded || enabled {
                content
                    .disabled(!enabled)
                    .opacity(enabled ? 1 : 0)
                    .onAppear {
                        self.loaded = true
                }
            } else {
                Spacer()
            }
        }.preference(key: _IOS6TabItemKey.self, value: [IOS6TabBarStyleConfiguration.Label(label, id: (tag ?? id as AnyHashable))])
    }
    
    init(label: @escaping () -> AnyView) {
        self.label = label
    }
}

extension View {
    /// Sets the IOS6 tab bar item associated with this view.
    /// - Parameters:
    ///   - label: a label that represent the current view
    /// - Returns: some View
    public func ios6TabItem<V>(@ViewBuilder _ label: @escaping () -> V) -> some View where V : View {
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
