//
//  IOS6List.swift
//  IOS6
//
//  Created by Xuan Li on 7/1/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

/// A container that presents rows of data arranged in a single column
/// with etched lines.
public struct IOS6List<Content: View>: View {
    let content: () -> Content
    let cellBgC: UIColor?
    let bgC: UIColor?
    
    public var body: some View {
        List {
            content()
        }
        .buttonStyle(IOS6ListButtonStyle())
        .onAppear {
            UITableView.appearance().backgroundColor = self.bgC
            UITableViewCell.appearance().backgroundColor = self.cellBgC
            UITableView.appearance().separatorStyle = .none
            UIView.appearance().isExclusiveTouch = true
        }
    }
    
    /// An initializer with background color and cell background color.
    /// - Parameters:
    ///   - bgC: list background color
    ///   - cellBgC: cell background color
    ///   - content: content view builder
    public init(bgC: UIColor? = nil, cellBgC: UIColor? = nil, @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.cellBgC = cellBgC ?? UIColor(red: 247.0/255.0, green: 247.0/255.0, blue: 247.0/255.0, alpha: 1)
        self.bgC = bgC ?? UIColor(red: 247.0/255.0, green: 247.0/255.0, blue: 247.0/255.0, alpha: 1)
    }
}

struct IOS6List_Previews: PreviewProvider {
    static var previews: some View {
        IOS6List {
            Text("Hello, World!")
        }
    }
}
