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
    @Environment(\._ios6SelectedTab) var globalId
    @Environment(\._ios6Tag) var tag
    let _title: Text
    let _icon: Image
    let _insets: EdgeInsets
    
    func body(content: Content) -> some View {
        let enabled = globalId == (tag ?? id as AnyHashable)
        return Group {
            Spacer()
                .preference(key: _IOS6TabItemKey.self,
                            value: [IOS6TabBarStyleConfiguration.Label(_title, _icon, insets: _insets, id: (tag ?? id as AnyHashable))])
            
            if self.loaded || enabled {
                content
                    .opacity(enabled ? 1 : 0)
                    .onAppear {
                        self.loaded = true
                }
            }
        }
    }
    
    init(title: Text, icon: Image, insets: EdgeInsets) {
        self._title = title
        self._icon = icon
        self._insets = insets
    }
}

extension View {
    /// Sets the IOS6 tab bar item associated with this view.
    /// - Parameters:
    ///   - title: title label
    ///   - icon: icon label
    /// - Returns: some View
    public func ios6TabItem(title: () -> Text, icon: () -> Image, insets: EdgeInsets = EdgeInsets()) -> some View {
        modifier(_IOS6TabItem(title: title(), icon: icon(), insets: insets))
    }
    
    /// Sets the IOS6 tab bar item associated with this view.
    /// - Parameters:
    ///   - title: title
    ///   - name: system image name
    /// - Returns: some View
    public func ios6TabItem<S>(_ title: S, systemImage name: String, insets: EdgeInsets = EdgeInsets()) -> some View where S : StringProtocol {
        modifier(_IOS6TabItem(title: Text(title), icon: Image(systemName: name).resizable(), insets: insets))
    }
    
    /// Sets the IOS6 tab bar item associated with this view.
    /// - Parameters:
    ///   - title: A string to used as the label’s title.
    ///   - icon: icon label
    /// - Returns: some View
    public func ios6TabItem<S>(_ title: S, icon: () -> Image, insets: EdgeInsets = EdgeInsets()) -> some View where S : StringProtocol {
        modifier(_IOS6TabItem(title: Text(title), icon: icon(), insets: insets))
    }
    
    /// Sets the IOS6 tab bar item associated with this view.
    /// - Parameters:
    ///   - title: A string to used as the label’s title.
    ///   - image: The name of the image resource to lookup.
    /// - Returns: some View
    public func ios6TabItem<S>(_ title: S, image: String, insets: EdgeInsets = EdgeInsets()) -> some View where S : StringProtocol {
        modifier(_IOS6TabItem(title: Text(title), icon: Image(image).resizable(), insets: insets))
    }
}

struct _IOS6TabItemKey: PreferenceKey {
    static var defaultValue: [IOS6TabBarStyleConfiguration.Label] = []
    
    static func reduce(value: inout [IOS6TabBarStyleConfiguration.Label], nextValue: () -> [IOS6TabBarStyleConfiguration.Label]) {
        value.append(contentsOf: nextValue())
    }
}

struct _IOS6SelectedTabKey: EnvironmentKey {
    static var defaultValue: AnyHashable? = nil
}

extension EnvironmentValues {
    var _ios6SelectedTab: AnyHashable? {
        get { return self[_IOS6SelectedTabKey.self] }
        set { self[_IOS6SelectedTabKey.self] = newValue }
    }
}
