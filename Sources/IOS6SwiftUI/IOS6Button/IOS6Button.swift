//
//  IOS6Button.swift
//  IOS6
//
//  Created by Xuan Li on 5/14/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

public struct IOS6Button<Label: View>: View {
    let action: () -> Void
    let label: Label
    let position: IOS6SectionItemPosition
    let background: LinearGradient
    @State private var pressing: Bool = false
    @Environment(\.isEnabled) private var isEnable
    
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
        }) {
            label
        }
        .buttonStyle(IOS6ButtonStyle(at: position, is: pressing, background: background))
    }
    
    public init(background: LinearGradient? = nil, action: @escaping () -> Void, label: () -> Label, sectionPostion: IOS6SectionItemPosition = .none) {
        self.action = action
        self.label = label()
        self.background = background ?? IOS6ButtonDefaultBackground
        self.position = sectionPostion
    }
}

struct IOS6Button_Previews: PreviewProvider {
    static var previews: some View {
        IOS6Button(action: {}, label: {Text("D")})
    }
}
