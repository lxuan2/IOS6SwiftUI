//
//  PresentMode.swift
//  IOS6
//
//  Created by Xuan Li on 5/13/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

public struct PresentMode {
    let show: Binding<Bool>?
    
    public var isPresented: Bool {
        show != nil
    }
    
    public func dismiss(with animation: Animation? = .default) {
        withAnimation(animation) {
            self.show?.wrappedValue = false
        }
    }
}

public struct PresentModeKey: EnvironmentKey {
    public static var defaultValue: Binding<PresentMode> {
        .constant(PresentMode(show: nil))
    }
}

public extension EnvironmentValues {
    var presentMode: Binding<PresentMode> {
        get { return self[PresentModeKey.self] }
        set { self[PresentModeKey.self] = newValue }
    }
}
