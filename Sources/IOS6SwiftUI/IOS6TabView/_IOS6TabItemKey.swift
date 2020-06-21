//
//  _IOS6TabItemKey.swift
//  IOS6
//
//  Created by Xuan Li on 6/16/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

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

