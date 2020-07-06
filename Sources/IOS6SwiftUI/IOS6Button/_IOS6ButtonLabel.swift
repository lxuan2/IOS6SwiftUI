//
//  _IOS6ButtonLabel.swift
//  IOS6
//
//  Created by Xuan Li on 5/28/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

/// `Private API`:
/// A button label providing default layout for IOS6Button and IOS6NavigationLink.
public struct _IOS6ButtonLabel<Label: View>: View {
    @Environment(\.isEnabled) private var isEnabled
    private let isPressed: Bool
    private let label: Label
    private let position: IOS6FormCellSectionPosition
    private let isLink: Bool
    
    public var body: some View {
        label
            .frame(maxWidth: self.frame, maxHeight: self.frame, alignment: self.alignment)
            .contentShape(Rectangle())
            .background(
                ZStack {
                    EmptyView()
                    if isPressed && self.position == .none {
                        IOS6ButtonDefaultBackground
                    }
            })
            .modifier(_IOS6FormCellConfig(at: self.position, background: IOS6ButtonDefaultListBackground, isLink: isLink))
            ._ios6ActiveColor(isPressed ? .white : nil)
            .opacity(self.isEnabled ? 1 : 0.9)
    }
    
    init(_ isPressed: Bool, label: Label, sectionPostion: IOS6FormCellSectionPosition, isLink: Bool) {
        self.isPressed = isPressed
        self.label = label
        self.position = sectionPostion
        self.isLink = isLink
    }
    
    private var frame: CGFloat? {
        position == .none ? .none : .infinity
    }
    
    private var alignment: Alignment {
        position == .none ? .center : .leading
    }
    
    private let IOS6ButtonDefaultBackground =
        LinearGradient(
            gradient: Gradient(colors:
                [Color(red: 6.0/255.0, green: 137.0/255.0, blue: 243.0/255.0),
                 Color(red: 0.0/255.0, green: 95.0/255.0, blue: 230.0/255.0)]),
            startPoint: .top, endPoint: .bottom)
    
    private var IOS6ButtonDefaultListBackground: some View {
        IOS6ButtonDefaultBackground
            .opacity(isPressed ? 1 : 0)
            .overlay(
                HStack {
                    Spacer()
                    if isLink {
                        Image(systemName: "chevron.right")
                            .font(Font.footnote.weight(.heavy))
                            .ios6ForegroundColor(isPressed ? .white : Color(red: 120.0/255.0, green: 120.0/255.0, blue: 120.0/255.0))
                            .padding(.trailing, 12)
                    }
            })
    }
}

struct IOS6ButtonLabel_Previews: PreviewProvider {
    static var previews: some View {
        _IOS6ButtonLabel(false, label: Text("test"), sectionPostion: .none, isLink: false)
    }
}
