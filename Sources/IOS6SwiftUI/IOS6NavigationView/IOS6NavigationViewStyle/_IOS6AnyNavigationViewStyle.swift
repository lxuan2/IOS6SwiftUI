//
//  _IOS6AnyNavigationViewStyle.swift
//  test
//
//  Created by Xuan Li on 8/19/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct _IOS6AnyNavigationViewStyle: IOS6NavigationViewStyle {
    private let styleMakeBody: (Configuration) -> AnyView
    private let styleMakeMasterBody: (ComponentConfiguration) -> AnyView
    private let styleMakeDetailBody: (ComponentConfiguration) -> AnyView
    
    init<S: IOS6NavigationViewStyle>(_ style: S) {
        self.styleMakeBody = style.makeTypeErasedBody
        self.styleMakeMasterBody = style.makeTypeErasedMasterBody
        self.styleMakeDetailBody = style.makeTypeErasedDetailBody
    }
    
    func makeBody(configuration: Configuration) -> AnyView {
        self.styleMakeBody(configuration)
    }
    
    func makeMasterBody(configuration: ComponentConfiguration) -> AnyView {
        self.styleMakeMasterBody(configuration)
    }
    
    func makeDetailBody(configuration: ComponentConfiguration) -> AnyView {
        self.styleMakeDetailBody(configuration)
    }
}

fileprivate extension IOS6NavigationViewStyle {
    func makeTypeErasedBody(configuration: Configuration) -> AnyView {
        AnyView(makeBody(configuration: configuration))
    }
    
    func makeTypeErasedMasterBody(configuration: ComponentConfiguration) -> AnyView {
        AnyView(makeMasterBody(configuration: configuration))
    }
    
    func makeTypeErasedDetailBody(configuration: ComponentConfiguration) -> AnyView {
        AnyView(makeDetailBody(configuration: configuration))
    }
}
