//
//  IOS6NavigationPage.swift
//  IOS6
//
//  Created by Xuan Li on 4/25/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

class IOS6NavigationPage: Identifiable {
    // TODO: Need Coordinator for variable title
    let content: IOS6NavigationPageView
    let title: String?
    let lock: Binding<Bool>?
    let id: UUID
    
    init<Page: View>(page: Page, title: String?  = nil, previousPageLock: Binding<Bool>? = nil) {
        content = IOS6NavigationPageView(page: page)
        self.title = title
        lock = previousPageLock
        id = UUID()
    }
}
