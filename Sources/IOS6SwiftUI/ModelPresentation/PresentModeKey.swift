//
//  PresentMode.swift
//  IOS6
//
//  Created by Xuan Li on 5/13/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

public struct PresentModeKey: EnvironmentKey {
    public static var defaultValue: PresentMode {
        PresentMode()
    }
}

public extension EnvironmentValues {
    var presentMode: PresentMode {
        get { return self[PresentModeKey.self] }
        set { self[PresentModeKey.self] = newValue }
    }
}

public struct PresentMode {
    let show: Binding<Bool>?
    let dismissFunc: (() -> Void)?
    
    init(show: Binding<Bool>? = nil, dismiss: (() -> Void)? = nil) {
        self.show = show
        self.dismissFunc = dismiss
    }
    
    public var isPresented: Bool {
        show != nil || dismissFunc != nil
    }
    
    public func dismiss() {
        if dismissFunc != nil {
            return self.dismissFunc!()
        }
        self.show?.wrappedValue = false
    }
}
