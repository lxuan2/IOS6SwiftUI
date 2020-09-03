//
//  IOS6StatusBar.swift
//  IOS6
//
//  Created by Xuan Li on 7/5/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct _IOS6StatusBar<Label: View>: ViewModifier {
    @Environment(\._ios6IsEnabled) var ios6IsEnabled
    let label: Label
    
    func body(content: Content) -> some View {
        content.preference(key: _IOS6StatusBarKey.self,
                           value: ios6IsEnabled ? _IOS6StatusBarData(label: AnyView(label), id: Int32.random(in: 0..<Int32.max)) : nil)
    }
}

extension View {
    /// Set Status Bar Background View.
    ///
    ///  Powered by IOS6RootView
    ///
    /// - Parameter background: background view
    /// - Returns: some View
    public func ios6StatusBar<Background: View>(_ background: Background) -> some View {
        modifier(_IOS6StatusBar(label: background))
    }
}

struct _IOS6StatusBarData: Equatable, Identifiable {
    let label: AnyView
    let id: Int32
    
    init(label: AnyView, id: Int32) {
        self.id = id
        self.label = label
    }
    
    static func == (lhs: _IOS6StatusBarData, rhs: _IOS6StatusBarData) -> Bool {
        lhs.id == rhs.id
    }
}

struct _IOS6StatusBarKey: PreferenceKey {
    typealias Value = _IOS6StatusBarData?
    
    static var defaultValue: Value = nil
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = value ?? nextValue()
    }
}
