//
//  IOS6NavigationLink.swift
//  animation
//
//  Created by Xuan Li on 1/22/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI
import Foundation

/// A view that controls a navigation presentation with IOS 6 style.
public struct IOS6NavigationLink<Label: View, SubLabel: View, Destination : View>: View {
    let label: (Bool) -> Label
    let destination: Destination
    @State private var sheet = false
    @Environment(\.ios6NavigationStack) private var stack
    
    public var body: some View {
        Button(action: {
            if self.stack != nil {
                self.sheet = true
                self.stack!.push(isPresent: self.$sheet,
                                 newView: self.destination)
            }
        }, label: {EmptyView()})
            .buttonStyle(IOS6ButtonStyle() { isPressed in
                    self.label(isPressed || self.sheet)
            })
    }
}

extension IOS6NavigationLink where SubLabel == Never {
    public init(destination: () -> Destination, label: @escaping (Bool) -> Label) {
        self.destination = destination()
        self.label = label
    }
}

public extension IOS6NavigationLink where Label == IOS6ButtonLabel<SubLabel> {
    init(destination: () -> Destination, label: @escaping () -> SubLabel, sectionPostion position: IOS6SectionItemPosition = .none) {
        self.init(label: { isPressed in
            IOS6ButtonLabel(isPressed, label: label(), sectionPostion: position, isLink: true)
        }, destination: destination())
    }
}

struct IOS6NavigationLink_Previews: PreviewProvider {
    static var previews: some View {
        IOS6NavigationView {
            IOS6Form {
                IOS6NavigationLink(destination: {Text("Hello World")}) {
                    Text("Tap Me")
                }
            }
        }
    }
}
