//
//  IOS6PresentationMode.swift
//  IOS6
//
//  Created by Xuan Li on 5/13/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct _IOS6PresentationModeKey: EnvironmentKey {
    static var defaultValue: IOS6PresentationMode {
        IOS6PresentationMode()
    }
}

extension EnvironmentValues {
    public var ios6PresentationMode: IOS6PresentationMode {
        get { return self[_IOS6PresentationModeKey.self] }
        set { self[_IOS6PresentationModeKey.self] = newValue }
    }
}
