//
//  IOS6Toggle.swift
//  animation
//
//  Created by Xuan Li on 2/10/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

/// A control that toggles between "on" and "off" states with IOS 6 style.
public struct IOS6Toggle<Label: View>: View {
    var isOn: Binding<Bool>
    var label: () -> Label
    let position: IOS6SectionItemPosition
    
    public init(isOn: Binding<Bool>, @ViewBuilder label: @escaping () -> Label, sectionPostion: IOS6SectionItemPosition = .none) {
        self.isOn = isOn
        self.label = label
        self.position = sectionPostion
    }
    
    public var body: some View {
        Toggle(isOn: isOn) {
            label()
        }
            .toggleStyle(IOS6ToggleStyle())
            .ios6FormRowPos(position)
    }
}

struct IOS6Toggle_Previews: PreviewProvider {
    static var previews: some View {
        IOS6Toggle(isOn: .constant(false)) {
            Text("toggle")
        }
    }
}
