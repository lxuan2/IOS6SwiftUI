//
//  IOS6Form.swift
//  animation
//
//  Created by Xuan Li on 1/14/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

var Done: Bool = false
/// A container for grouping controls used for data entry, such as in settings
/// or inspectors with IOS 6 style.
public struct IOS6Form<Content: View>: View {
    let content: () -> Content
    
    public var body: some View {
//        ScrollView() {
//            VStack(spacing: 0) {
//                self.content()
//            }
//        }
        List {
            self.content()
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
    }
    
    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
        if !Done {
            UITableView.appearance().backgroundColor = UIColor.clear
            UITableViewCell.appearance().backgroundColor = .clear
            UITableView.appearance().separatorStyle = .none
            Done.toggle()
        }
    }
}

struct IOS6Form_Previews: PreviewProvider {
    static var previews: some View {
        IOS6Form {
            Text("Form View")
        }
    }
}
