//
//  IOS6ToggleStyle.swift
//  IOS6
//
//  Created by Xuan Li on 5/8/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

/// IOS6 Toggle Style
public struct IOS6ToggleStyle: ToggleStyle {
    
    public func makeBody(configuration: IOS6ToggleStyle.Configuration) -> some View {
        IOS6ToggleStyleView(configuration)
    }
    
    struct IOS6ToggleStyleView: View {
        let configuration: IOS6ToggleStyle.Configuration
        @State private var percent: CGFloat
        
        var body: some View {
            HStack {
                configuration.label
                Spacer(minLength: 3)
                _IOS6ToggleView(isOn: configuration.$isOn.onChange{ value in
                    self.percent = value ? 1 : 0
                })
            }
            .listRowInsets(.init(top: 8.5, leading: 11, bottom: 9.5, trailing: 14))
        }
        
        init(_ configuration: IOS6ToggleStyle.Configuration) {
            self.configuration = configuration
            self._percent = State(initialValue: configuration.isOn ? 1 : 0)
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

extension Binding where Value: Equatable {
    // Updates the binding then calls a closure woith the new value
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        Binding (
            get: { self.wrappedValue },
            set: { selection in
                if self.wrappedValue != selection {
                    self.wrappedValue = selection
                    handler(selection)
                }
            }
        )
    }
}
