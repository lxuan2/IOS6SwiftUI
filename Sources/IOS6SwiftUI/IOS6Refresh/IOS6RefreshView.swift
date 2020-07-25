//
//  IOS6RefreshView.swift
//  IOS6
//
//  Created by Xuan Li on 7/23/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

public struct IOS6RefreshView<Content: View>: View {
    let content: () -> Content
    let onRefresh: (() -> Void)?
    @State private var padding: CGFloat = 0
    @State private var shift: CGFloat = 0
    
    public var body: some View {
        GeometryReader { base in
            ScrollView(.vertical) {
                GeometryReader { child in
                    VStack(spacing: 0) {
                        Spacer(minLength: self.padding)
                        self.content()
                    }
                    .preference(key: _IOS6ShiftAmountPreferenceKey.self, value: min(child.frame(in: .global).minY - base.frame(in: .global).minY, 96))
                }
            }
            
        }
        .onPreferenceChange(_IOS6ShiftAmountPreferenceKey.self) { value in
            self.shift = value
        }
        .overlay(
            IOS6RefreshControl(shift: $shift,
                               padding: self.$padding,
                               onRefresh: self.onRefresh),
            alignment: .top)
    }
    
    public init(onRefresh: (() -> Void)? = nil, content: @escaping () -> Content) {
        self.content = content
        self.onRefresh = onRefresh
    }
}

struct _IOS6ShiftAmountPreferenceKey: PreferenceKey {
    typealias Value = CGFloat
    
    static var defaultValue: Value = 0
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue() + value
    }
}

struct IOS6RefreshView_Previews: PreviewProvider {
    static var previews: some View {
        IOS6RefreshView(onRefresh: { print("D") }) {
            Color.red.frame(width: 375, height: 100)
        }
    }
}
