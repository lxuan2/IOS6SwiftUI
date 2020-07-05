//
//  IOS6NavigationLink.swift
//  animation
//
//  Created by Xuan Li on 1/22/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI
import Foundation

/// A button that triggers a IOS6 style navigation presentation when pressed.
///
/// This button is similar to IOS6Button. Default debounced behavior is given,
/// and provides selected state by keeping pressing state. Also allow customized
/// button style.
public struct IOS6NavigationLink<Label: View, SubLabel: View, Destination : View>: View {
    private let label: (Bool) -> Label
    private let destination: Destination
    @State private var sheet = false
    @Environment(\._ios6NavigationStack) private var stack
    
    public var body: some View {
        Button(action: {
            if self.stack != nil, !self.stack!.blocking {
                self.sheet = true
                self.stack!.push(isPresent: self.$sheet,
                                 newView: self.destination)
            }
        }, label: {EmptyView()})
            .buttonStyle(_IOS6ButtonStyle { isPressed in
                    self.label(isPressed || self.sheet)
            })
            .disabled(stack == nil)
    }
}

extension IOS6NavigationLink where SubLabel == Never {
    /// A initializer with desination view and customized label view
    ///
    /// This initializer is designed to allow customized button style.
    /// The `Bool` Value indicates whether the button is pressed.
    ///
    /// - Parameters:
    ///   - destination: a view that will be presented.
    ///   - label: a content view given whether the button is pressed.
    public init(destination: Destination, label: @escaping (Bool) -> Label) {
        self.destination = destination
        self.label = label
    }
}

extension IOS6NavigationLink where Label == _IOS6ButtonLabel<SubLabel> {
    /// A initializer with desination view and label view
    ///
    /// Default button style is given with highlight color: blue.
    /// - Parameters:
    ///   - destination: a view that will be presented.
    ///   - label: a content view.
    ///   - position: the position in IOS6Form / IOS6List section.
    public init(destination: Destination, label: @escaping () -> SubLabel, sectionPostion position: IOS6FormCellSectionPosition = .none) {
        self.init(label: { isPressed in
            _IOS6ButtonLabel(isPressed, label: label(), sectionPostion: position, isLink: true)
        }, destination: destination)
    }
}

struct IOS6NavigationLink_Previews: PreviewProvider {
    static var previews: some View {
        IOS6NavigationView {
            IOS6Form {
                IOS6NavigationLink(destination: Text("Hello World")) {
                    Text("Tap Me")
                }
            }
        }
    }
}
