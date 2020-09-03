//
//  IOS6NavigationConfiguration.swift
//  Demo
//
//  Created by Xuan Li on 9/3/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

public protocol IOS6NavigationConfiguration {
    
    /// A `View` representing the body of a ContentBackground.
    associatedtype ContentBackground : View
    
    /// A `View` representing the body of a ToolBarBackground.
    associatedtype ToolBarBackground : View
    
    /// A `View` representing the body of a NavigationBarBackground.
    associatedtype NavigationBarBackground : View
    
    /// A `View` representing the body of a NavigationBarBackButtonBody.
    associatedtype NavigationBarBackButtonBody : View
    
    /// A `ButtonStyle` representing the bar button style.
    associatedtype BarButtonStyle : ButtonStyle
    
    /// Declares the content background of this view.
    var contentBackground: Self.ContentBackground { get }
    
    /// Declares the tool bar background of this view.
    var toolBarBackground: Self.ToolBarBackground { get }
    
    /// Declares the navigation bar background of this view.
    var navigationBarBackground: Self.NavigationBarBackground { get }
    
    /// Declares the navigation bar button style of this view.
    var barButtonStyle: Self.BarButtonStyle { get }
    
    /// Creates a `View` representing the body of a `IOS6NavigationView`.
    ///
    /// - Parameter configuration: The properties of the IOS6NavigationView
    ///   instance being created.
    ///
    /// This method will be called for each instance of `IOS6NavigationView` created within
    /// a view hierarchy where this style is the current `IOS6NavigationViewStyle`.
    func makeNavigationBarBackButtonBody(configuration: IOS6NavigationBarBackButtonConfiguration) -> Self.NavigationBarBackButtonBody
}

public struct IOS6NavigationBarBackButtonConfiguration {

    /// A view that describes the effect of calling `action`.
    public let label: PrimitiveButtonStyleConfiguration.Label

    /// Whether or not the button is currently being pressed down by the user.
    public let isPressed: Bool
    
}
