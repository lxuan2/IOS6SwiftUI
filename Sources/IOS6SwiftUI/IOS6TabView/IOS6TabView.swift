//
//  IOS6TabView.swift
//  IOS6
//
//  Created by Xuan Li on 6/15/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

/// A view that switches between multiple child views using interactive user interface elements.
///
/// To create a user interface with tabs, place views in a TabView and apply the ios6TabItem(_:)
/// modifier to the contents of each tab.
public struct IOS6TabView<SelectionValue: Hashable, Content: View>: View {
    @State private var data: [IOS6TabBarStyleConfiguration.Item] = []
    @State private var hashedSelection: AnyHashable? = nil
    private let selection: Binding<SelectionValue>?
    private let content: Content
    
    public var body: some View {
        VStack {
            ZStack {
                Color.white
                    .edgesIgnoringSafeArea([.horizontal, .bottom])
                content
            }.padding(.bottom, 50)
        }
        .overlay(_IOS6TabBar(selection: $hashedSelection.onChange(self.updateSelection), labels: data), alignment: .bottom)
        .environment(\._ios6SelectedTab, item)
        .onPreferenceChange(_IOS6TabItemKey.self) { value in
            let sorted = value.sorted { first, second in
                if let firstInt = first.tag as? Int {
                    if let secondInt = second.tag as? Int {
                        return firstInt < secondInt
                    } else {
                        return true
                    }
                }
                return false
            }
            self.data = sorted
            self.tabItemsChangeHandler(items: sorted)
        }
    }
    
    var item : AnyHashable? {
        if let _ = hashedSelection as? SelectionValue,
            selection?.wrappedValue != hashedSelection,
            data.map({ $0.tag }).contains(selection?.wrappedValue) {
            DispatchQueue.main.async {
                self.hashedSelection = self.selection?.wrappedValue
            }
        }
        return hashedSelection
    }
    
    private func tabItemsChangeHandler(items: [IOS6TabBarStyleConfiguration.Item]) {
        if !items.isEmpty {
            if self.hashedSelection == nil {
                if items.map({ $0.tag }).contains(self.selection?.wrappedValue) {
                    self.hashedSelection = self.selection?.wrappedValue
                } else {
                    self.hashedSelection = items[0].tag
                    self.updateSelection(items[0].tag)
                }
            } else if !items.map({ $0.tag }).contains(self.hashedSelection) {
                self.hashedSelection = items[0].tag
                self.updateSelection(items[0].tag)
            }
        } else {
            self.hashedSelection = nil
        }
    }
    
    private func updateSelection(_ value: AnyHashable?) {
        if self.selection != nil, let casted = value as? SelectionValue {
            self.selection!.wrappedValue = casted
        }
    }
    
    public init(selection: Binding<SelectionValue>, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.selection = selection
    }
}

extension IOS6TabView where SelectionValue == Int {
    
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
        self.selection = nil
    }
}

struct IOS6TabView_Previews: PreviewProvider {
    static var previews: some View {
        IOS6TabView {
            Text("Hello, World!")
            Text("Hello, World!")
            Text("Hello, World!")
            Text("Hello, World!")
        }
    }
}
