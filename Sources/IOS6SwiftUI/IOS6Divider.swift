//
//  IOS6Divider.swift
//  animation
//
//  Created by Xuan Li on 1/23/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

public struct IOS6Divider: View {
    let color: Color = Color(red: 202.0/255.0, green: 202.0/255.0, blue: 202.0/255.0)
    let width: CGFloat = 1
    public var body: some View {
        Rectangle()
            .fill(color)
            .frame(maxWidth: .infinity, minHeight: width, maxHeight: width)
            .background(
                Rectangle()
                    .fill(Color(red: 253.0/255.0, green: 253.0/255.0, blue: 253.0/255.0))
                    .frame(height: width)
                .offset(x: 0, y: width)
            )
    }
}

struct IOS6Divider_Previews: PreviewProvider {
    static var previews: some View {
        IOS6Divider()
    }
}
