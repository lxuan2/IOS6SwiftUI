//
//  IOS6NavigationLinkItem.swift
//  animation
//
//  Created by Xuan Li on 1/25/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

/// A view for navigation link apperance with IOS 6 style.
public struct IOS6NavigationLinkItem: View {
    var image: Image? = nil
    let title: String
    var comment: String = ""
    
    public var body: some View {
        HStack(spacing: 0) {
            if image != nil {
                image!.resizable()
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .overlay(   // Round frame
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.black.opacity(0.4), lineWidth: 0.5)
                    )
                    .scaledToFit()
                    .padding(.vertical, 7)
                    .padding(.leading, 8)
                    .frame(height: 44.25)
            }
            
            Spacer().frame(width: 12)
            
            Text(title)
                .padding(.vertical, 10)
                .accentColor(.black)
            
            Spacer()
            
            if !comment.isEmpty {
                Text(comment)
                    .padding(.vertical, 10)
                    .accentColor(Color(red: 68.0/255.0, green: 90.0/255.0, blue: 140.0/255.0))
                    .font(.body)
            }
        }
    }
    
    public init(image: Image? = nil, title: String, comment: String = "") {
        self.image = image
        self.title = title
        self.comment = comment
    }
}

struct IOS6NavigationLinkItemView_Previews: PreviewProvider {
    static var previews: some View {
        IOS6NavigationLinkItem(image: Image("ins"), title: "Airplane Mode", comment: "NETGEAR22-5G")
    }
}
