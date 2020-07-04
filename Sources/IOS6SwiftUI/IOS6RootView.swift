//
//  IOS6RootView.swift
//  IOS6
//
//  Created by Xuan Li on 7/4/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct IOS6RootView<Content: View>: View {
    let rootView: () -> Content
    
    var body: some View {
        rootView()
    }
    
    init(@ViewBuilder rootView: @escaping () -> Content) {
        self.rootView = rootView
    }
}

struct IOS6RootView_Previews: PreviewProvider {
    static var previews: some View {
        IOS6RootView {
            Text("Test")
        }
    }
}
