//
//  IOS6List.swift
//  IOS6
//
//  Created by Xuan Li on 7/1/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

public struct IOS6List<Content: View>: View {
    let content: () -> Content
    let cellBgC: UIColor?
    let bgC: UIColor?
    
    public var body: some View {
        List {
            content()
        }.onAppear {
            UITableView.appearance().backgroundColor = self.bgC
            UITableViewCell.appearance().backgroundColor = self.cellBgC
            UITableView.appearance().separatorStyle = .none
            UITableView.appearance().tableHeaderView = nil
            UITableView.appearance().tableFooterView = nil
            UIView.appearance().isExclusiveTouch = true
        }
    }
    
    public init(bgC: UIColor? = nil, cellBgC: UIColor? = nil, @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.cellBgC = cellBgC
        self.bgC = bgC
    }
}

struct IOS6List_Previews: PreviewProvider {
    static var previews: some View {
        IOS6List {
            Text("Hello, World!")
        }
    }
}
