//
//  IOS6Form.swift
//  animation
//
//  Created by Xuan Li on 1/14/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

/// A container for grouping controls used for data entry, such as in settings
/// or inspectors with IOS 6 style.
public struct IOS6Form<Content: View>: View {
    let content: () -> Content
    @Environment(\.enableView) var enableView: Bool
    
    public var body: some View {
        ScrollView(showsIndicators: enableView) {
            VStack(spacing: 0) {
                self.content()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
    
    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
}

struct IOS6Form_Previews: PreviewProvider {
    static var previews: some View {
        IOS6Form {
            Text("Form View")
        }
    }
}

struct EnableViewKey: EnvironmentKey {
    static var defaultValue: Bool {
        return true
    }
}

extension EnvironmentValues {
    var enableView: Bool {
        get { return self[EnableViewKey.self] }
        set { self[EnableViewKey.self] = newValue }
    }
}
