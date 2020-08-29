//
//  _IOS6NavigationTitleKey.swift
//  IOS6
//
//  Created by Xuan Li on 5/3/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

/// `Private API`:
/// A preference key for navigation bar title
struct _IOS6NavigationTitleKey: PreferenceKey {
    typealias Value = [String?]
    
    static var defaultValue: Value = []
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value.append(contentsOf: nextValue())
    }
}

extension View {
    /// Set IOS6 navigation bar title for current view
    ///
    /// Capable with IOS6NavigationView
    ///
    /// - Parameter title: title string
    /// - Returns: some View
    public func ios6NavigationTitle(_ title: String) -> some View {
        self.preference(key: _IOS6NavigationTitleKey.self, value: [title])
    }
}
