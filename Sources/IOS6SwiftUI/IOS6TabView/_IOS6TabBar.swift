//
//  _IOS6TabBar.swift
//  IOS6
//
//  Created by Xuan Li on 6/16/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct _IOS6TabBar: View {
    @Environment(\._ios6TabBarStyle) private var style
    let selection: Binding<AnyHashable?>
    let labels: [IOS6TabBarStyleConfiguration.Item]
    
    var body: some View {
        self.style.makeBody(configuration: IOS6TabBarStyleConfiguration(selection: selection, items: labels))
    }
    
    init(selection: Binding<AnyHashable?>, labels: [IOS6TabBarStyleConfiguration.Item]) {
        self.selection = selection
        self.labels = labels
    }
}
