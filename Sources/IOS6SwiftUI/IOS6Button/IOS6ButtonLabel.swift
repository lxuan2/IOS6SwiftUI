//
//  IOS6ButtonLabel.swift
//  IOS6
//
//  Created by Xuan Li on 5/28/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

public struct IOS6ButtonLabel<Label: View>: View {
    @Environment(\.isEnabled) private var isEnabled
    let isPressed: Bool
    let label: Label
    let position: IOS6SectionItemPosition
    let isLink: Bool
    
    public var body: some View {
        HStack(spacing: 0) {
            label
            if isLink {
                Spacer(minLength: 12)

                Image(systemName: "chevron.right")
                    .font(Font.footnote.weight(.heavy))
                    .ios6ForegroundColor(Color(red: 120.0/255.0, green: 120.0/255.0, blue: 120.0/255.0))
                    .padding(.trailing, 2)
            }
        }
            .frame(maxWidth: self.frame, maxHeight: self.frame, alignment: self.alignment)
            .contentShape(Rectangle())
            .ios6ActiveColor(isPressed ? .white : nil)
            .background(
                ZStack {
                    EmptyView()
                    if isPressed && self.position == .none {
                        IOS6ButtonDefaultBackground
                    }
            })
            .modifier(IOS6FormRowConfiguration(at: self.position, background: IOS6ButtonDefaultBackground.opacity(isPressed ? 1 : 0)))
            .opacity(self.isEnabled ? 1 : 0.9)
    }
    
    init(_ isPressed: Bool, label: Label, sectionPostion: IOS6SectionItemPosition = .none, isLink: Bool = false) {
        self.isPressed = isPressed
        self.label = label
        self.position = sectionPostion
        self.isLink = isLink
    }
    
    var frame: CGFloat? {
        position == .none ? .none : .infinity
    }
    
    var alignment: Alignment {
        position == .none ? .center : .leading
    }
    
    let IOS6ButtonDefaultBackground =
        LinearGradient(
            gradient: Gradient(colors:
                [Color(red: 60.0/255.0, green: 140.0/255.0, blue: 237.0/255.0),
                 Color(red: 34.0/255.0, green: 98.0/255.0, blue: 224.0/255.0)]),
            startPoint: .top, endPoint: .bottom)
}

struct IOS6ButtonLabel_Previews: PreviewProvider {
    static var previews: some View {
        IOS6ButtonLabel(false, label: Text("test"), sectionPostion: .none)
    }
}
