//
//  IOS6RootBackground.swift
//  IOS6
//
//  Created by Xuan Li on 7/4/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct _IOS6RootBackground<Label: View>: ViewModifier {
    @Environment(\._ios6IsEnabled) var ios6IsEnabled
    let label: Label
    
    func body(content: Content) -> some View {
        content.preference(key: _IOS6RootBackgroundKey.self,
                           value: ios6IsEnabled ? _IOS6RootBackgroundData(label: AnyView(label), id: Int32.random(in: 0..<Int32.max)) : nil)
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
        modifier(_IOS6RootBackground(label: background))
    }
}

struct _IOS6RootBackgroundData: Equatable, Identifiable {
    let label: AnyView
    let id: Int32
    
    init(label: AnyView, id: Int32) {
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
