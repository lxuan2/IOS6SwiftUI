//
//  IOS6TabView.swift
//  IOS6
//
//  Created by Xuan Li on 6/15/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

public struct IOS6TabView<Content: View>: View {
    @State private var selection: Int = 0
    private let outerSelction: Binding<Int>?
    private let content: () -> Content
    
    public var body: some View {
        _IOS6TabView(selection: outerSelction == nil ? $selection : outerSelction!, content: content)
            
    }
    
    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.outerSelction = nil
    }
    
    public init(selection: Binding<Int>, @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.outerSelction = selection
    }
}

extension Int {
    func threshold(_ minValue: Int, _ maxValue: Int) -> Int {
        Swift.min(maxValue, Swift.max(minValue, self))
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
