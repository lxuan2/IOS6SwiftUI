//
//  BlurSegmentedPickerEnvironmentKey.swift
//  IOS6
//
//  Created by Xuan Li on 8/5/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct BlurSegmentedPickerEnvironmentData {
    var selection: AnyHashable?
    var state: BlurSegmentedPickerState
}

struct BlurSegmentedPickerEnvironmentKey: EnvironmentKey {
    public static var defaultValue = BlurSegmentedPickerEnvironmentData(selection: nil, state: .idle)
}

extension EnvironmentValues {
    var pickerItem: BlurSegmentedPickerEnvironmentData {
        get { return self[BlurSegmentedPickerEnvironmentKey.self] }
        set { self[BlurSegmentedPickerEnvironmentKey.self] = newValue }
    }
}
