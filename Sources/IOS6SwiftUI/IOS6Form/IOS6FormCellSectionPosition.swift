//
//  IOS6FormCellSectionPosition.swift
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
public enum IOS6FormCellSectionPosition: Equatable {
    case top
    case medium
    case bottom
    case single
    case list
    case none
    
    public static func == (lhs: IOS6FormCellSectionPosition, rhs: IOS6FormCellSectionPosition) -> Bool {
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

extension View {
    /// Configure the position in IOS6Form / IOS6List when developing the customized
    /// view not in this packages.
    ///
    /// Setting the postion gives the cell in the IOS6Form / IOS6List with correct shadow.
    /// The list cell background is allowed to be customized in this function.
    ///
    /// - Parameters:
    ///   - postion: position in IOS6Form(.top, .bottom, .medium, .single) / IOS6List(.list)
    ///   - background: customized background for the cell in IOS6Form / IOS6List
    /// - Returns: some View
    public func ios6SecPosition<Background: View>(_ postion: IOS6FormCellSectionPosition, background: Background) -> some View {
        self.modifier(_IOS6FormCellConfig(at: postion, background: background))
    }
    
    /// Configure the position in IOS6Form / IOS6List when developing the customized
    /// view not in this packages.
    ///
    /// Setting the postion gives the cell in the IOS6Form / IOS6List with correct shadow.
    /// No background view is given.
    ///
    /// - Parameter postion: position in IOS6Form(.top, .bottom, .medium, .single) / IOS6List(.list)
    /// - Returns: some View
    public func ios6SecPosition(_ postion: IOS6FormCellSectionPosition) -> some View {
        self.modifier(_IOS6FormCellConfig(at: postion, background: EmptyView()))
    }
}
