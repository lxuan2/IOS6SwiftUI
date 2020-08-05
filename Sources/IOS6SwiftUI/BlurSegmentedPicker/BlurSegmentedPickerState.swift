//
//  BlurSegmentedPickerState.swift
//  IOS6
//
//  Created by Xuan Li on 8/5/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

enum BlurSegmentedPickerState: Equatable {
    case idle
    case active
    case quiteActive(startSelection: AnyHashable)
    
    func isIdle() -> Bool {
        self == .idle
    }
    
    func isActive() -> Bool {
        self == .active
    }
    
    func isQuiteActive() -> Bool {
        switch self {
        case .quiteActive:
            return true
        default:
            return false
        }
    }
    
    func getStartState() -> AnyHashable {
        switch self {
        case .quiteActive(let x):
            return x
        default:
            return 0
        }
    }
}
