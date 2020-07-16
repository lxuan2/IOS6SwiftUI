//
//  IOS6TabBarStyle.swift
//  IOS6
//
//  Created by Xuan Li on 7/15/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public protocol IOS6TabBarStyle {
    associatedtype Body : View
    
    func makeBody(configuration: Self.Configuration) -> Self.Body

    typealias Configuration = IOS6TabBarStyleConfiguration
}
