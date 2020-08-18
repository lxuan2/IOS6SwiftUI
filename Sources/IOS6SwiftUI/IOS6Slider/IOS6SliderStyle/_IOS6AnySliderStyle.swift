//
//  _IOS6AnySliderStyle.swift
//  Demo
//
//  Created by Xuan Li on 8/18/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct _IOS6AnySliderStyle: IOS6SliderStyle {
    private let styleMakeBody: (IOS6SliderStyle.Configuration) -> AnyView
    
    init<S: IOS6SliderStyle>(_ style: S) {
        self.styleMakeBody = style.makeTypeErasedBody
    }
    
    func makeBody(configuration: IOS6SliderStyle.Configuration) -> AnyView {
        self.styleMakeBody(configuration)
    }
}

fileprivate extension IOS6SliderStyle {
    func makeTypeErasedBody(configuration: IOS6SliderStyle.Configuration) -> AnyView {
        AnyView(makeBody(configuration: configuration))
    }
}
