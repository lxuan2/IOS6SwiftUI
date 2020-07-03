//
//  IOS6FormCellSectionPosition.swift
//  
//
//  Created by Xuan Li on 5/31/20.
//

import SwiftUI

public enum IOS6FormCellSectionPosition: Equatable {
    case top
    case medium
    case bottom
    case all
    case none
    case list
    
    public static func == (lhs: IOS6FormCellSectionPosition, rhs: IOS6FormCellSectionPosition) -> Bool {
        switch (lhs, rhs) {
        case (.top, .top):
            return true
        case (.medium,.medium):
            return true
        case (.bottom,.bottom):
            return true
        case (.all,.all):
            return true
        case (.none,.none):
            return true
        case (.list,.list):
            return true
        default:
            return false
        }
    }
}
