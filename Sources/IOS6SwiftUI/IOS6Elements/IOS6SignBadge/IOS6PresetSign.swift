//
//  IOS6PresetSign.swift
//  Demo
//
//  Created by Xuan Li on 8/15/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

public enum IOS6PresetSign {
    case xmark_red
    case checkmark_blue
    case checkmark_green
    case arrow_blue
    
    var string: String {
        switch self {
        case .xmark_red:
            return "xmark"
        case .checkmark_blue, .checkmark_green:
            return "checkmark"
        case .arrow_blue:
            return "chevron.right"
        }
    }
}
