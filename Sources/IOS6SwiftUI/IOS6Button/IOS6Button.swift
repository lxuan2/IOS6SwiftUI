//
//  DebounceButton.swift
//  IOS6
//
//  Created by Xuan Li on 5/27/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

public struct IOS6Button<Label: View, SubLabel: View>: View {
    @State private var pressing: Bool = false
    let action: () -> Void
    let label: (Bool) -> Label
    
    public var body: some View {
        Button(action: {
            DispatchQueue.main.async {
                self.pressing = true
            }
            self.action()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.easeOut(duration: 0.1)) {
                    self.pressing = false
                }
            }
        }, label: {EmptyView()})
            .buttonStyle(IOS6ButtonStyle() { isPressed in
                self.label(isPressed || self.pressing)
            })
    }
}

extension IOS6Button where SubLabel == Never {
    public init(action: @escaping () -> Void, label: @escaping (Bool) -> Label) {
        self.action = action
        self.label = label
    }
}

public extension IOS6Button where Label == IOS6ButtonLabel<SubLabel> {
    init(action: @escaping () -> Void, label: @escaping () -> SubLabel, sectionPostion position: IOS6SectionItemPosition = .none) {
        self.init(action: action, label: { isPressed in IOS6ButtonLabel(isPressed, label: label(), sectionPostion: position, isLink: false)})
    }
}

struct DebounceButton_Previews: PreviewProvider {
    static var previews: some View {
        IOS6Button(action: {}, label: { _ in Text("Debounce Button")})
    }
}
