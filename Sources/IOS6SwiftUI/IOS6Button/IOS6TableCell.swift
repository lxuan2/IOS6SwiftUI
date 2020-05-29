//
//  IOS6TableCell.swift
//  IOS6
//
//  Created by Xuan Li on 5/9/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

/// A view for row apperance in the form with IOS 6 style.
public struct IOS6TableCell<Comment: View>: View {
    let image: Image?
    let title: String
    let commentView: Comment?
    let commentIsText: Bool
    @Environment(\.isEnabled) private var isEnable
    
    public var body: some View {
        HStack(spacing: 0) {
            if image != nil {
                image!
                    .renderingMode(.original)
                    .resizable()
                    .cornerRadius(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.black.opacity(0.4), lineWidth: 0.5)
                )
                    .scaledToFit()
                    .layoutPriority(2)
                    .padding(.trailing, 10)
            }
            
            Text(title)
                .fontWeight(.bold)
                .ios6ForegroundColor(isEnable ? .black : Color(red: 0.4, green: 0.4, blue: 0.4))
                .padding(.horizontal, 2)
                .layoutPriority(1)
            
            if commentView != nil {
                Spacer(minLength: 10)
                
                commentView
                    .ios6ForegroundColor(!commentIsText ? .white : isEnable ? .accentColor : Color(red: 0.4, green: 0.4, blue: 0.4))
                    .layoutPriority(0)
            }
        }
        .frame(minHeight: 30, maxHeight: 30)
        .opacity(isEnable ? 1 : 0.7)
    }
    
    public init(image: Image? = nil, title: String, comment: Comment?) {
        self.image = image
        self.title = title
        commentView = comment
        commentIsText = false
    }
    
    private var NoImage: Bool {
        image == nil
    }
}

extension IOS6TableCell where Comment == Text {
    public init<S>(image: Image? = nil, title: String, comment: S) where S : StringProtocol {
        self.image = image
        self.title = title
        commentView = comment.isEmpty ? nil : Text(comment).fontWeight(.medium)
        commentIsText = true
    }
    
    public init(image: Image? = nil, title: String) {
        self.image = image
        self.title = title
        commentView = nil
        commentIsText = false
    }
}

struct IOS6TableCell_Previews: PreviewProvider {
    static var previews: some View {
        IOS6TableCell(image: Image("ins"), title: "Airplane Mode", comment: "NETGEAR22-5G")
    }
}
