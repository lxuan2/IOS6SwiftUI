//
//  IOS6ToggleStyle.swift
//  IOS6
//
//  Created by Xuan Li on 5/8/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

public struct IOS6ToggleStyle: ToggleStyle {

    public func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            _IOS6ToggleView(isOn: configuration.$isOn)
        }
    }
}

struct IOS6ToggleStyle_Previews: PreviewProvider {
    static var previews: some View {
        Toggle(isOn: .constant(false)) {
            Text("Toggle")
        }
        .toggleStyle(IOS6ToggleStyle())
    }
}
