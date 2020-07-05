//
//  _IOS6TabView.swift
//  IOS6
//
//  Created by Xuan Li on 6/16/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct _IOS6TabView<Content: View>: View {
    @State private var data: [_IOS6TabItemData] = []
    @State private var staticID = UUID()
    @Binding private var selection: Int
    let content: () -> Content
    
    var body: some View {
        VStack {
            ZStack {
                Color.white
                    .edgesIgnoringSafeArea([.horizontal, .bottom])
                content()
            }.padding(.bottom, 50)
        }
        .overlay(_IOS6TabBarView(selection: $selection, items: $data), alignment: .bottom)
        .environment(\._ios6Tab, id)
        .onPreferenceChange(_IOS6TabItemKey.self) { items in
            self.data = items
        }
    }
    
    var id: UUID {
        let index = selection.threshold(0, data.count - 1)
        if index < 0 {
            return staticID
        }
        return data[index].id
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
