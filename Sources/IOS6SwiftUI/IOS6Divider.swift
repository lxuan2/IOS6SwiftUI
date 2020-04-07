//
//  IOS6Divider.swift
//  animation
//
//  Created by Xuan Li on 1/23/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

public struct IOS6Divider: View {
    let color: Color
    let width: CGFloat
    
    public var body: some View {
        color
            .frame(minHeight: width, maxHeight: width)
    }
    
    init(width: CGFloat = 1, color: Color = Color(red: 202.0/255.0, green: 202.0/255.0, blue: 202.0/255.0)) {
        self.width = width
        self.color = color
    }
}

struct IOS6Divider_Previews: PreviewProvider {
    static var previews: some View {
        IOS6Divider()
    }
}
