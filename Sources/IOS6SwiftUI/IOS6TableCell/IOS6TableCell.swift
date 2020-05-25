//
//  IOS6TableCell.swift
//  IOS6
//
//  Created by Xuan Li on 5/9/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

/// A view for row apperance in the form with IOS 6 style.
public struct IOS6TableCell: View {
    let image: Image?
    let title: String
    let comment: String
    @Environment(\.isEnabled) private var isEnable
    
    public var body: some View {
        let view = comment.isEmpty ? nil :
            Optional(
                Text(comment)
                    .ios6ForegroundColor(isEnable ?
                        Color(red: 68.0/255.0, green: 90.0/255.0, blue: 140.0/255.0) :
                        Color(red: 0.4, green: 0.4, blue: 0.4)))
        return IOS6TableCellAdv(image: image, title: title, comment: view)
    }
    
    public init(image: Image? = nil, title: String, comment: String = "") {
        self.image = image
        self.title = title
        self.comment = comment
    }
}

struct IOS6TableCell_Previews: PreviewProvider {
    static var previews: some View {
        IOS6TableCell(image: Image("ins"), title: "Airplane Mode", comment: "NETGEAR22-5G")
    }
}
