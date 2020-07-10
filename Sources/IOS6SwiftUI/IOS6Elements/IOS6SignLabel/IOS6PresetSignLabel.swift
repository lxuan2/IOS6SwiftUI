//
//  IOS6PresetSignLabel.swift
//  IOS6
//
//  Created by Xuan Li on 7/8/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

public struct IOS6PresetSignLabel: View {
    let isPressed: Bool
    let sign: IOS6PresetSign
    
    public var body: some View {
        IOS6SignLabel(color: color, isPressed: isPressed, paddingScale: scale) {
            Image(systemName: self.name)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .font(Font.caption.weight(.heavy))
        }
    }
    
    var color: Color? {
        switch sign {
        case .xmark_red:
            return isPressed ?
                Color(red: 70/255.0, green: 0/255.0, blue: 10/255.0) :
                Color(red: 145/255.0, green: 0/255.0, blue: 14/255.0)
        case .checkmark_green:
            return isPressed ?
                Color(red: 0/255.0, green: 90/255.0, blue: 0/255.0) :
                Color(red: 0/255.0, green: 164/255.0, blue: 0/255.0)
        default:
            return nil
        }
    }
    
    var name: String {
        switch sign {
        case .xmark_red:
            return "xmark"
        case .checkmark_blue, .checkmark_green:
            return "checkmark"
        case .arrow_blue:
            return "chevron.right"
        }
    }
    
    var scale: CGFloat {
        switch sign {
        case .xmark_red:
            return 2.8
        case .checkmark_blue, .checkmark_green:
            return 2.5
        case .arrow_blue:
            return 2.4
        }
    }
    
    public init(isPressed: Bool = false, sign: IOS6PresetSign) {
        self.isPressed = isPressed
        self.sign = sign
    }
}

struct IOS6XMarkPopOver_Previews: PreviewProvider {
    static var previews: some View {
        IOS6PresetSignLabel(sign: .arrow_blue)
    }
}

public enum IOS6PresetSign {
    case xmark_red
    case checkmark_blue
    case checkmark_green
    case arrow_blue
}
