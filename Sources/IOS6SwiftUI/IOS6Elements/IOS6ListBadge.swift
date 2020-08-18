//
//  IOS6ListBadge.swift
//  Demo
//
//  Created by Xuan Li on 8/15/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

public struct IOS6ListBadge: View {
    let content: Text
    
    public var body: some View {
        content
            .font(Font.headline.weight(.bold))
            .blendMode(.destinationOut)
            .padding(.horizontal, 11)
            .frame(minWidth: 30)
            .background(
                ZStack {
                    Capsule(style: .circular)
                        .fill(Color.white)
                    
                    Capsule(style: .circular)
                        .strokeBorder(
                            LinearGradient(gradient: Gradient(colors: [
                                                                Color.black.opacity(0.15),
                                                                Color.gray.opacity(0.2)]),
                                           startPoint: .top, endPoint: .bottom), lineWidth: 0.8)
                }
                .ios6ForegroundColor(regular: Color(red: 138/255.0, green: 152/255.0, blue: 182/255.0), active: .white)
            )
    }
    
    public init<S>(text: S) where S : StringProtocol {
        self.content = Text(text)
    }
}

struct IOS6ListBadge_Previews: PreviewProvider {
    static var previews: some View {
        IOS6ListBadge(text: "1")
    }
}
