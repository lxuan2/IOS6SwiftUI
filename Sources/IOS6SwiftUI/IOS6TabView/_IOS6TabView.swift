//
//  _IOS6TabView.swift
//  IOS6
//
//  Created by Xuan Li on 6/16/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct _IOS6TabView<Content: View>: View {
    @State private var items: [_IOS6TabItemData] = [_IOS6TabItemData(content: EmptyView(), label: EmptyView())]
    @Binding private var selection: Int
    let content: () -> Content
    let tabBarHeight: CGFloat = 50
    
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .bottom) {
                Color.white
                    .zIndex(0)
                
                self.items[self.index].content
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.bottom, proxy.safeAreaInsets.bottom + self.tabBarHeight)
                    .zIndex(1)
                
                _IOS6TabBarView(selection: self.$selection, items: self.$items, safeBottomHeight: proxy.safeAreaInsets.bottom, height: self.tabBarHeight)
                    .edgesIgnoringSafeArea(.all)
                    .zIndex(2)
            }
    }
        .background(
            ZStack {
                self.content()
            }
            .hidden()
            .onPreferenceChange(_IOS6TabItemKey.self) { items in
                self.items = [_IOS6TabItemData(content: EmptyView(), label: EmptyView())] + items
            }
        )
    }
    
    private var index: Int {
        return items.count == 1 ? 0 : (selection + 1).threshold(1, items.count - 1)
    }
    
    init(selection: Binding<Int>, @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self._selection = selection
    }
}

struct _IOS6TabView_Previews: PreviewProvider {
    static var previews: some View {
        _IOS6TabView(selection: .constant(0), content: { Text("Test") })
    }
}
