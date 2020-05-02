//
//  IOS6Form.swift
//  animation
//
//  Created by Xuan Li on 1/14/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

/// A container for grouping controls used for data entry, such as in settings
/// or inspectors with IOS 6 style.
public struct IOS6Form<Content: View>: View {
    let content: () -> Content
    
    public var body: some View {
        Form {
            //            Section{
            //                EmptyView()
            //            }
            self.content()
        }
        .environment(\.horizontalSizeClass, .regular)
            //        .padding(.horizontal, -3.5)
            //        .padding(.vertical, -12.5)
            .padding(.vertical, -13)
    }
    
    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
        UITableView.appearance().backgroundColor = UIColor.clear
        UITableViewCell.appearance().backgroundColor = UIColor(red: 247.0/255.0, green: 247.0/255.0, blue: 247.0/255.0, alpha: 1)
        UITableView.appearance().separatorStyle = .none
        UIView.appearance().isExclusiveTouch = true
        //            UITableView.appearance().sectionHeaderHeight = 12.8
        //            UITableView.appearance().sectionFooterHeight = 12.8
    }
}

struct IOS6Form_Previews: PreviewProvider {
    static var previews: some View {
        IOS6Form {
            Text("Form View")
        }
    }
}
