//
//  NavigationStackModel.swift
//  IOS6
//
//  Created by Xuan Li on 4/28/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import UIKit

protocol NavigationStackModel: RandomAccessCollection {
    func push<Content>(_ newValue: Content)
    func pop()
}
