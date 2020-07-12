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
    private let content: () -> Content
    private let sectionSpace: CGFloat = 17.5
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    public var body: some View {
        Form {
            self.content()
                .environment(\.horizontalSizeClass, self.horizontalSizeClass)
        }
        .environment(\.horizontalSizeClass, .regular)
        .onAppear {
            UITableView.appearance().backgroundColor = UIColor.clear
            UITableViewCell.appearance().backgroundColor = UIColor(red: 247.0/255.0, green: 247.0/255.0, blue: 247.0/255.0, alpha: 1)
            UITableView.appearance().separatorStyle = .none
//            UITableView.appearance().sectionHeaderHeight = 15
//            UITableView.appearance().sectionFooterHeight = 15
//            UITableView.appearance().tableHeaderView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 0, height: self.sectionSpace)))
//            UITableView.appearance().tableFooterView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 0, height: self.sectionSpace)))
            UIView.appearance().isExclusiveTouch = true
        }
    }
    
    /// An initializer with view builder.
    /// - Parameter content: view builder content
    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
}

struct IOS6Form_Previews: PreviewProvider {
    static var previews: some View {
        IOS6Form {
            Text("Form View")
        }
    }
}
