//
//  IOS6StatusBar.swift
//  IOS6
//
//  Created by Xuan Li on 7/5/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct _IOS6StatusBar: ViewModifier {
    @State private var id: UUID = UUID()
    let label: () -> AnyView
    
    func body(content: Content) -> some View {
        content.preference(key: _IOS6StatusBarKey.self, value: _IOS6StatusBarData(label: label, id: id))
    }
}

extension View {
    public func ios6StatusBar<Background: View>(_ background: Background) -> some View {
        modifier(_IOS6StatusBar(label: {
            AnyView(background)
        }))
    }
}

struct _IOS6StatusBarData: Equatable, Identifiable {
    let label: () -> AnyView
    let id: UUID
    
    init(label: @escaping () -> AnyView, id: UUID) {
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
