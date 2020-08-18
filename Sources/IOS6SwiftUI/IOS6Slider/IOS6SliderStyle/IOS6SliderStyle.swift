//
//  IOS6SliderStyle.swift
//  Demo
//
//  Created by Xuan Li on 8/18/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

public protocol IOS6SliderStyle {

    /// A `View` representing the body of a `IOS6Slider`.
    associatedtype Body : View

    /// Creates a `View` representing the body of a `IOS6Slider`.
    ///
    /// - Parameter configuration: The properties of the IOS6Slider
    ///   instance being created.
    ///
    /// This method will be called for each instance of `IOS6Slider` created within
    /// a view hierarchy where this style is the current `IOS6SliderStyle`.
    func makeBody(configuration: Self.Configuration) -> Self.Body

    /// The properties of a `Toggle` instance being created.
    typealias Configuration = IOS6SliderStyleConfiguration
}
