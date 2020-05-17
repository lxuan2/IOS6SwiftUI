//
//  PresentationKey.swift
//  IOS6
//
//  Created by Xuan Li on 5/16/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct PresentationKey: PreferenceKey {
    typealias Value = Bool
    
    static var defaultValue: Value = false
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue() || value
    }
}
