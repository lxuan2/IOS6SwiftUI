//
//  BlurSegmentedPickerPreferenceKey.swift
//  IOS6
//
//  Created by Xuan Li on 8/5/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct BlurSegmentedPickerItemData {
    let id: AnyHashable
    let bounds: Anchor<CGRect>
}

struct BlurSegmentedPickerPreferenceKey: PreferenceKey {
    typealias Value = [BlurSegmentedPickerItemData]
    
    static var defaultValue: [BlurSegmentedPickerItemData] = []
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value.append(contentsOf: nextValue())
    }
}
