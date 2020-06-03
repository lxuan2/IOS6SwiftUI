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
    private let content: Content
    private let sectionSpace: CGFloat = 15
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    public var body: some View {
        Form {
            self.content
                .environment(\.horizontalSizeClass, self.horizontalSizeClass)
        }
        .environment(\.horizontalSizeClass, .regular)
    }
    
    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
        UITableView.appearance().backgroundColor = UIColor.clear
        UITableViewCell.appearance().backgroundColor = UIColor(red: 247.0/255.0, green: 247.0/255.0, blue: 247.0/255.0, alpha: 1)
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().sectionHeaderHeight = sectionSpace
        UITableView.appearance().sectionFooterHeight = sectionSpace
        UITableView.appearance().tableHeaderView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 0, height: sectionSpace + 1)))
        UITableView.appearance().tableFooterView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 0, height: sectionSpace)))
        UIView.appearance().isExclusiveTouch = true
    }
}

struct IOS6Form_Previews: PreviewProvider {
    static var previews: some View {
        IOS6Form {
            Text("Form View")
        }
    }
}
