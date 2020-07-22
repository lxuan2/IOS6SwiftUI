//
//  IOS6PresetTableCell.swift
//  IOS6
//
//  Created by Xuan Li on 5/9/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

/// A view for row apperance in the form with IOS 6 style.
///
/// This is a recommanded layout template for cells in IOS6Form / IOS6List.
public struct IOS6PresetTableCell<Comment: View>: View {
    private let image: Image?
    private let title: String
    private let commentView: Comment?
    private let commentIsText: Bool
    
    public var body: some View {
        HStack(spacing: 0) {
            if image != nil {
                image!
                    .resizable()
                    .cornerRadius(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .strokeBorder(Color.white.opacity(0.3), lineWidth: 1))
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .strokeBorder(Color.black.opacity(0.4), lineWidth: 0.5))
                    .scaledToFit()
                    .padding(.trailing, 9.5)
                    .layoutPriority(2)
            }
            
            Text(title)
                .fontWeight(.bold)
                .ios6ForegroundColor(regular: .black, active: .white)
                .shadow(radius: 0, x: 0, y: 0.5)
                .fixedSize(horizontal: true, vertical: false)
                .padding(.horizontal, 3.5)
                .layoutPriority(1)
            
            if commentView != nil {
                Spacer(minLength: 9.5)
                
                commentView
                    .ios6ForegroundColor(regular: !commentIsText ? .white : .accentColor, active: .white)
                    .layoutPriority(0)
            }
        }
        .frame(minHeight: 30, maxHeight: 30)
    }
    
    /// An initializer with image, title and comment.
    /// - Parameters:
    ///   - image: image view to be presented in the front
    ///   - title: title behind the image
    ///   - comment: comment after title using ios6ForegroundColors
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

extension IOS6PresetTableCell where Comment == Text {
    /// An initializer with image view, title and comment string.
    /// - Parameters:
    ///   - image: image view to be presented in the front
    ///   - title: title behind the image
    ///   - comment: comment text after title using ios6ForegroundColors
    public init<S>(image: Image? = nil, title: String, comment: S) where S : StringProtocol {
        self.image = image
        self.title = title
        commentView = comment.isEmpty ? nil : Text(comment).fontWeight(.medium)
        commentIsText = true
    }
    
    /// An initializer with image view, title.
    /// - Parameters:
    ///   - image: image view to be presented in the front
    ///   - title: title behind the images
    public init(image: Image? = nil, title: String) {
        self.image = image
        self.title = title
        commentView = nil
        commentIsText = false
    }
}

struct IOS6TableCell_Previews: PreviewProvider {
    static var previews: some View {
        IOS6PresetTableCell(image: Image("ins"), title: "Airplane Mode", comment: "NETGEAR22-5G")
    }
}
