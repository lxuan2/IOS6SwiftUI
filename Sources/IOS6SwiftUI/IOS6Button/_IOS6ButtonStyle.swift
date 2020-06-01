//
//  _IOS6ButtonStyle.swift
//  IOS6
//
//  Created by Xuan Li on 5/13/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct _IOS6ButtonStyle<Label: View>: ButtonStyle {
    private let label: (Bool) -> Label
    
    init(label: @escaping (Bool) -> Label) {
        self.label = label
    }
    
    func makeBody(configuration: _IOS6ButtonStyle.Configuration) -> some View {
        _IOS6ButtonStyleButton(configuration: configuration, label: label)
    }
    
    private struct _IOS6ButtonStyleButton: View {
        let configuration: _IOS6ButtonStyle.Configuration
        let label: (Bool) -> Label
        @State private var isPressed: Bool = false
        
        var body: some View {
            if isPressed != configuration.isPressed {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    self.isPressed = self.configuration.isPressed
                }
            }
            return label(isPressed && configuration.isPressed)
        }
    }
}

struct DebounceButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Button("Not Shown") {}
            .buttonStyle(_IOS6ButtonStyle { isPressed in
                Text("Shown")
                    .foregroundColor(isPressed ? .red : .black)
            })
    }
}
