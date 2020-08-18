//
//  _IOS6SliderStyleEnvironmentKey.swift
//  Demo
//
//  Created by Xuan Li on 8/18/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct _IOS6SliderStyleEnvironmentKey: EnvironmentKey {
    static let defaultValue: _IOS6AnySliderStyle = _IOS6AnySliderStyle(IOS6BlueSliderStyle())
}

extension EnvironmentValues {
    var _ios6SliderStyle: _IOS6AnySliderStyle {
        get {
            return self[_IOS6SliderStyleEnvironmentKey.self]
        }
        set {
            self[_IOS6SliderStyleEnvironmentKey.self] = newValue
        }
    }
}

public extension View {
    func ios6SliderStyle<S>(_ style: S) -> some View where S : IOS6SliderStyle {
        environment(\._ios6SliderStyle, _IOS6AnySliderStyle(style))
    }
}
