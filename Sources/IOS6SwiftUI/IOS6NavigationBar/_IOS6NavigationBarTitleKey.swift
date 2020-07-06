//
//  _IOS6NavigationBarTitleKey.swift
//  IOS6
//
//  Created by Xuan Li on 5/3/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

/// `Private API`:
/// A preference key for navigation bar title
struct _IOS6NavigationBarTitleKey: PreferenceKey {
    typealias Value = String?
    
    static var defaultValue: Value = nil
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue() ?? value
    }
}

extension View {
    /// Set IOS6 navigation bar title for current view
    ///
    /// Capable with IOS6NavigationView
    ///
    /// - Parameter title: title string
    /// - Returns: some View
    public func ios6NavigationBarTitle(_ title: String) -> some View {
        self.preference(key: _IOS6NavigationBarTitleKey.self, value: title)
    }
}
