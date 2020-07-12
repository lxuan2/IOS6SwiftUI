//
//  IOS6SectionPosition.swift
//  
//
//  Created by Xuan Li on 5/31/20.
//

import SwiftUI

/// The cell position in IOS6Form / IOS6List.
///
/// This enum is used to indicate where is the cell in IOS6Form / IOS6List.
/// By giving correct position, the cell has correct background shadow.
/// .
public enum IOS6SectionPosition: Equatable {
    case top
    case medium
    case bottom
    case single
    case list
    case none
    
    public static func == (lhs: IOS6SectionPosition, rhs: IOS6SectionPosition) -> Bool {
        switch (lhs, rhs) {
        case (.top, .top):
            return true
        case (.medium,.medium):
            return true
        case (.bottom,.bottom):
            return true
        case (.single,.single):
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
