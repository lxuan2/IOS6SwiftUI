//
//  IOS6ToggleStyle.swift
//  IOS6
//
//  Created by Xuan Li on 5/8/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct IOS6ToggleStyle: ToggleStyle {
    var color: Color
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            IOS6ToggleView(isOn: configuration.$isOn, toggleColor: color)
        }
    }
}

struct IOS6ToggleColorKey: EnvironmentKey {
    static var defaultValue: Color = Color(red: 0/255.0, green: 127/255.0, blue: 234/255.0)
    // Color(red: 0/255.0, green: 127/255.0, blue: 234/255.0) blue
    // Color(red: 255.0/255.0, green: 127.0/255.0, blue: 2.0/255.0) orange
}

extension EnvironmentValues {
    public var ios6ToggleColor: Color {
        get { return self[IOS6ToggleColorKey.self] }
        set { self[IOS6ToggleColorKey.self] = newValue }
    }
}

struct IOS6ToggleStyle_Previews: PreviewProvider {
    static var previews: some View {
        Toggle(isOn: .constant(false)) {
            Text("Toggle")
        }
        .toggleStyle(IOS6ToggleStyle(color: Color.green))
    }
}
