//
//  IOS6FormCellPosition.swift
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
public enum IOS6FormCellPosition: Equatable {
    case top
    case mid
    case bottom
    case single
    case none
    
    public static func == (lhs: IOS6FormCellPosition, rhs: IOS6FormCellPosition) -> Bool {
        switch (lhs, rhs) {
        case (.top, .top):
            return true
        case (.mid,.mid):
            return true
        case (.bottom,.bottom):
            return true
        case (.single,.single):
            return true
        case (.none,.none):
            return true
        default:
            return false
        }
    }
}

struct _IOS6SectionPositionEnvironmentKey: EnvironmentKey {
    public static var defaultValue: IOS6FormCellPosition = .none
}

extension EnvironmentValues {
    var _ios6SectionPosition: IOS6FormCellPosition {
        get { return self[_IOS6SectionPositionEnvironmentKey.self] }
        set { self[_IOS6SectionPositionEnvironmentKey.self] = newValue }
    }
}
