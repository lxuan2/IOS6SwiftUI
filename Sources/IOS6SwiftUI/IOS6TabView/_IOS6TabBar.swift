//
//  _IOS6TabBar.swift
//  IOS6
//
//  Created by Xuan Li on 6/16/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct _IOS6TabBar: View {
    @Environment(\.ios6TabBarStyle) private var style
    
    private var configuration: IOS6TabBarStyleConfiguration
    
    var body: some View {
        self.style.makeBody(configuration:
            self.configuration
        )
    }
    
    init(selection: Binding<AnyHashable?>, items: [IOS6TabBarStyleConfiguration.Label]) {
        self.configuration = IOS6TabBarStyleConfiguration(selection: selection, labels: items)
    }
}
