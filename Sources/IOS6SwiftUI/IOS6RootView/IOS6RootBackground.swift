//
//  IOS6RootBackground.swift
//  IOS6
//
//  Created by Xuan Li on 7/4/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct _IOS6RootBackground: ViewModifier {
    @State private var id: UUID = UUID()
    @Environment(\.isEnabled) var isEnabled
    let label: () -> AnyView
    
    func body(content: Content) -> some View {
        content.preference(key: _IOS6RootBackgroundKey.self, value: isEnabled ? _IOS6RootBackgroundData(label: label, id: id) : nil)
    }
}

extension View {
    /// Set IOS6 root view background.
    ///
    /// Powered by IOS6RootView
    /// 
    /// - Parameter background: background view
    /// - Returns: some view
    public func ios6RootBackground<Background: View>(_ background: Background) -> some View {
        modifier(_IOS6RootBackground(label: {
            AnyView(background)
        }))
    }
}

struct _IOS6RootBackgroundData: Equatable, Identifiable {
    let label: () -> AnyView
    let id: UUID
    
    init(label: @escaping () -> AnyView, id: UUID) {
        self.id = id
        self.label = label
    }
    
    static func == (lhs: _IOS6RootBackgroundData, rhs: _IOS6RootBackgroundData) -> Bool {
        lhs.id == rhs.id
    }
}

struct _IOS6RootBackgroundKey: PreferenceKey {
    typealias Value = _IOS6RootBackgroundData?
    
    static var defaultValue: Value = nil
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = value ?? nextValue()
    }
}
