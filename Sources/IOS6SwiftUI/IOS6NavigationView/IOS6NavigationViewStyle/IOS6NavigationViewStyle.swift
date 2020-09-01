//
//  IOS6NavigationViewStyle.swift
//  test
//
//  Created by Xuan Li on 8/19/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

public protocol IOS6NavigationViewStyle {

    /// A `View` representing the body of a `IOS6NavigationView`.
    associatedtype Body : View
    
    /// A `View` representing the body of a `master` of `IOS6NavigationView`.
    associatedtype MasterBody : View
    
    /// A `View` representing the body of a `detail` of `IOS6NavigationView`.
    associatedtype DetailBody : View

    /// Creates a `View` representing the body of a `IOS6NavigationView`.
    ///
    /// - Parameter configuration: The properties of the IOS6NavigationView
    ///   instance being created.
    ///
    /// This method will be called for each instance of `IOS6NavigationView` created within
    /// a view hierarchy where this style is the current `IOS6NavigationViewStyle`.
    func makeBody(configuration: Self.Configuration) -> Self.Body
    
    /// Creates a `View` representing the `master` body of a `IOS6NavigationView`.
    ///
    /// - Parameter configuration: The component properties of the IOS6NavigationView
    ///   instance being created.
    ///
    /// This method will be called for each instance of `IOS6NavigationView` created within
    /// a view hierarchy where this style is the current `IOS6NavigationViewStyle`.
    func makeMasterBody(configuration: Self.ComponentConfiguration) -> Self.MasterBody
    
    /// Creates a `View` representing the `detail` body of a `IOS6NavigationView`.
    ///
    /// - Parameter configuration: The component properties of the IOS6NavigationView
    ///   instance being created.
    ///
    /// This method will be called for each instance of `IOS6NavigationView` created within
    /// a view hierarchy where this style is the current `IOS6NavigationViewStyle`.
    func makeDetailBody(configuration: Self.ComponentConfiguration) -> Self.DetailBody

    /// The properties of a `IOS6NavigationView` instance being created.
    typealias Configuration = IOS6NavigationViewStyleConfiguration
    
    /// The component properties of a `IOS6NavigationView` instance being created.
    typealias ComponentConfiguration = IOS6NavigationViewStyleComponentConfiguration
}

extension IOS6NavigationViewStyle {
    public func makeMasterBody(configuration: Self.ComponentConfiguration) -> some View {
        configuration.root
    }
    
    public func makeDetailBody(configuration: Self.ComponentConfiguration) -> some View {
        configuration.root
    }
}
