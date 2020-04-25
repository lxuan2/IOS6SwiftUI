//
//  IOS6Divider.swift
//  animation
//
//  Created by Xuan Li on 1/23/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

public struct IOS6Divider: View {
    let width: CGFloat = 1
    
    public var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Color.white
                .frame(minHeight: width, maxHeight: width)
                
                Spacer()
                
                Color.black.opacity(0.18)
                    .frame(minHeight: width, maxHeight: width)
            }
            
            HStack {
                Color(red: 180.0/255.0, green: 180.0/255.0, blue: 180.0/255.0)
                    .frame(minWidth: width, maxWidth: width)
                
                Spacer()
                
                Color(red: 180.0/255.0, green: 180.0/255.0, blue: 180.0/255.0)
                    .frame(minWidth: width, maxWidth: width)
            }
        }
    }
    
    public init() {}
}

struct IOS6Divider_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(red: 247.0/255.0, green: 247.0/255.0, blue: 247.0/255.0)
        IOS6Divider()
        }
    }
}

