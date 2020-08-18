//
//  IOS6PresetSignBadge.swift
//  IOS6
//
//  Created by Xuan Li on 7/8/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

public struct IOS6PresetSignBadge: View {
    @Environment(\.ios6ButtonSelected) private var isSelected
    let sign: IOS6PresetSign
    
    public var body: some View {
        IOS6Badge(regularColor: regularColor, activeColor: activeColor, paddingRatio: scale) {
            Image(systemName: sign.string)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .font(Font.callout.weight(.black))
        }
    }
    
    var regularColor: Color? {
        switch sign {
        case .xmark_red:
            return Color(red: 145/255.0, green: 0/255.0, blue: 14/255.0)
        case .checkmark_green:
            return Color(red: 0/255.0, green: 164/255.0, blue: 0/255.0)
        case .checkmark_blue, .arrow_blue :
            return nil
        }
    }
    
    var activeColor: Color? {
        switch sign {
        case .xmark_red:
            return Color(red: 70/255.0, green: 0/255.0, blue: 10/255.0)
        case .checkmark_green:
            return Color(red: 0/255.0, green: 90/255.0, blue: 0/255.0)
        case .checkmark_blue, .arrow_blue :
            return nil
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
    
    public init(sign: IOS6PresetSign) {
        self.sign = sign
    }
}

struct IOS6PresetSignIcon_Previews: PreviewProvider {
    static var previews: some View {
        IOS6PresetSignBadge(sign: .arrow_blue)
    }
}
