//
//  _IOS6AnyTabBarStyle.swift
//  IOS6
//
//  Created by Xuan Li on 7/15/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct _IOS6AnyTabBarStyle: IOS6TabBarStyle {
    private let styleMakeBody: (IOS6TabBarStyle.Configuration) -> AnyView
    
    init<S: IOS6TabBarStyle>(_ style: S) {
        self.styleMakeBody = style.makeTypeErasedBody
    }
    
    func makeBody(configuration: IOS6TabBarStyle.Configuration) -> AnyView {
        self.styleMakeBody(configuration)
    }
}

fileprivate extension IOS6TabBarStyle {
    func makeTypeErasedBody(configuration: IOS6TabBarStyle.Configuration) -> AnyView {
        AnyView(makeBody(configuration: configuration))
    }
}
