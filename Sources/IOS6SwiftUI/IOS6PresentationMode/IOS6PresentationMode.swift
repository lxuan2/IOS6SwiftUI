//
//  IOS6PresentationMode.swift
//  IOS6
//
//  Created by Xuan Li on 5/31/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

/// IOS6 Presentation Mode that controls presentation state.
public struct IOS6PresentationMode {
    private let show: Binding<Bool>?
    private let dismissFunc: (() -> Void)?
    
    init(show: Binding<Bool>? = nil, dismiss: (() -> Void)? = nil) {
        self.show = show
        self.dismissFunc = dismiss
    }
    
    /// Indicate wether the current view is presented by another view.
    public var isPresented: Bool {
        show != nil || dismissFunc != nil
    }
    
    /// Dismiss current view and return to parent view.
    public func dismiss() {
        if dismissFunc != nil {
            return self.dismissFunc!()
        }
        self.show?.wrappedValue = false
    }
}
