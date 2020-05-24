//
//  IOS6FormRowAdv.swift
//  IOS6
//
//  Created by Xuan Li on 5/24/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

/// An advanced view for row apperance in the form with
/// IOS 6 style.
public struct IOS6FormRowAdv<Comment: View>: View {
    let image: Image?
    let title: String
    let commentView: Comment?
    
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
                    .layoutPriority(2)
                
                Spacer().frame(width: 12)
            }
            
            Text(title)
                .fontWeight(Font.Weight.bold)
                .ios6ForegroundColor(.black)
                .frame(maxWidth: NoImage ? .infinity : nil, maxHeight: NoImage ? .infinity : nil)
                .layoutPriority(1)
            
            if commentView != nil {
                Spacer(minLength: 12)
                
                commentView
                    .layoutPriority(0)
            }
        }
        .frame(minHeight: 30, maxHeight: 30)
    }
    
    public init(image: Image? = nil, title: String, comment: Comment) {
        self.image = image
        self.title = title
        commentView = comment
    }
    
    private var NoImage: Bool {
        image == nil
    }
}

extension IOS6FormRowAdv where Comment == Text {
    
    public init<S>(image: Image? = nil, title: String, comment: S) where S : StringProtocol {
        self.image = image
        self.title = title
        commentView = comment.isEmpty ? nil : Text(comment)
    }
}

struct IOS6FormRowAdv_Previews: PreviewProvider {
    static var previews: some View {
        IOS6FormRowAdv(image: Image("ins"), title: "Airplane Mode", comment: Text("NETGEAR22-5G"))
    }
}
