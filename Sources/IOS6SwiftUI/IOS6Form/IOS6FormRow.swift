//
//  IOS6FormRow.swift
//  IOS6
//
//  Created by Xuan Li on 5/9/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

/// A view for row apperance in the form with IOS 6 style.
public struct IOS6FormRow: View {
    let image: Image?
    let title: String
    let comment: String
    
    public var body: some View {
        HStack(spacing: 0) {
            if image != nil {
                image!
                    .renderingMode(.original)
                    .resizable()
                    .cornerRadius(5)
                    .overlay(   // Round frame
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.black.opacity(0.4), lineWidth: 0.5)
                )
                    .scaledToFit()
            }
            
            Spacer().frame(width: image != nil ? 12: 6)
            
            Text(title)
                .fontWeight(Font.Weight.bold)
                .accentColor(.black)
            
            if !comment.isEmpty {
                Spacer()
                Text(comment)
                    .accentColor(Color(red: 68.0/255.0, green: 90.0/255.0, blue: 140.0/255.0))
            }
        }
        .frame(minHeight: 30, maxHeight: 30)
    }
    
    public init(image: Image? = nil, title: String, comment: String = "") {
        self.image = image
        self.title = title
        self.comment = comment
    }
}

struct IOS6FormRow_Previews: PreviewProvider {
    static var previews: some View {
        IOS6FormRow(image: Image("ins"), title: "Airplane Mode", comment: "NETGEAR22-5G")
    }
}
