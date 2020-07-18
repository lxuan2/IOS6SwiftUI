//
//  IOS6TabItem.swift
//  IOS6
//
//  Created by Xuan Li on 6/21/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct _IOS6TabItem<Title: View, Icon: View>: ViewModifier {
    @State private var id: UUID = UUID()
    @State private var loaded: Bool = false
    @Environment(\._ios6SelectedTab) var globalId
    @Environment(\._ios6Tag) var tag
    let _title: Title
    let _icon: Icon
    
    func body(content: Content) -> some View {
        let disabled = globalId != (tag ?? id as AnyHashable)
        return Group {
            Spacer()
                .preference(key: _IOS6TabItemKey.self,
                            value: [IOS6TabBarStyleConfiguration.Label(_title, _icon, id: (tag ?? id as AnyHashable))])
            
            if self.loaded || disabled {
                content
                    .ios6Disabled(disabled)
                    .opacity(disabled ? 0 : 1)
                    .onAppear {
                        self.loaded = true
                }
            }
        }
    }
    
    init(title: Title, icon: Icon) {
        self._title = title
        self._icon = icon
    }
}

extension View {
    /// Sets the IOS6 tab bar item associated with this view.
    /// - Parameters:
    ///   - title: title label
    ///   - icon: icon label
    /// - Returns: some View
    public func ios6TabItem<Title: View, Icon: View>(title: () -> Title, icon: () -> Icon) -> some View {
        modifier(_IOS6TabItem(title: title(), icon: icon()))
    }
    
    /// Sets the IOS6 tab bar item associated with this view.
    /// - Parameters:
    ///   - title: title
    ///   - name: system image name
    /// - Returns: some View
    public func ios6TabItem<S>(_ title: S, systemImage name: String) -> some View where S : StringProtocol {
        modifier(_IOS6TabItem(title: Text(title), icon: Image(systemName: name).resizable()))
    }
    
    /// Sets the IOS6 tab bar item associated with this view.
    /// - Parameters:
    ///   - title: A string to used as the label’s title.
    ///   - icon: icon label
    /// - Returns: some View
    public func ios6TabItem<S, Icon: View>(_ title: S, icon: () -> Icon) -> some View where S : StringProtocol {
        modifier(_IOS6TabItem(title: Text(title), icon: icon()))
    }
    
    /// Sets the IOS6 tab bar item associated with this view.
    /// - Parameters:
    ///   - title: A string to used as the label’s title.
    ///   - image: The name of the image resource to lookup.
    /// - Returns: some View
    public func ios6TabItem<S, Icon: View>(_ title: S, image: String) -> some View where S : StringProtocol {
        modifier(_IOS6TabItem(title: Text(title), icon: Image(image)))
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
