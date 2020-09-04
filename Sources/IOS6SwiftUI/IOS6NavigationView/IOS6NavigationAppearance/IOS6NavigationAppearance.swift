//
//  IOS6NavigationAppearance.swift
//  Demo
//
//  Created by Xuan Li on 9/3/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

public protocol IOS6NavigationAppearance {
    
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
    
    /// A `View` representing the the body of a text in navigation bar.
    associatedtype BarText : View
    
    /// Declares the content background of this view.
    var contentBackground: Self.ContentBackground { get }
    
    /// Declares the tool bar background of this view.
    var toolBarBackground: Self.ToolBarBackground { get }
    
    /// Declares the navigation bar background of this view.
    var navigationBarBackground: Self.NavigationBarBackground { get }
    
    /// Declares the navigation bar button style of this view.
    var barButtonStyle: Self.BarButtonStyle { get }
    
    /// Declares the status bar color of this view.
    var statusBarColor: Color { get }
    
    /// Declares the status bar color of this view.
    var accentColor: Color? { get }
    
    /// Creates a `View` representing the body of back button in navigation bar.
    ///
    /// - Parameter configuration: The properties of the IOS6NavigationBarBackButton
    ///   instance being created.
    func makeNavigationBarBackButtonBody(configuration: IOS6NavigationBarBackButtonConfiguration) -> Self.NavigationBarBackButtonBody
    
    /// Creates a `View` representing the body of a `IOS6NavigationView`.
    ///
    /// - Parameter content: The text `View` instance being created.
    func makeTextBody(content: Text) -> Self.BarText
}

public struct IOS6NavigationBarBackButtonConfiguration {

    /// A view that describes the effect of calling `action`.
    public let label: PrimitiveButtonStyleConfiguration.Label

    /// Whether or not the button is currently being pressed down by the user.
    public let isPressed: Bool
    
}
