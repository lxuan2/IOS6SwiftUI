//
//  PresentationKey.swift
//  IOS6
//
//  Created by Xuan Li on 5/16/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct PresentationKey: PreferenceKey {
    typealias Value = Bool
    
    static var defaultValue: Value = false
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue() || value
    }
}

public extension View {
    
    func present<Content: View>(isPresented: Binding<Bool>, with animation: Animation? = .default, @ViewBuilder content: @escaping () -> Content) -> some View {
        modifier(PresentViewModifer(isPresented: isPresented, with: animation, sheet: content))
    }
    
    func present<Content: View>(isPresented: Binding<Bool>, with style: UIModalPresentationStyle, content: @escaping () -> Content) -> some View {
        modifier(PresentViewModiferUIKit(isPresented: isPresented, with: style, given: nil, sheet: content))
    }
    
    func present<Content: View>(isPresented: Binding<Bool>, with transDelegate: UIViewControllerTransitioningDelegate, content: @escaping () -> Content) -> some View {
        modifier(PresentViewModiferUIKit(isPresented: isPresented, with: .custom, given: transDelegate, sheet: content))
    }
    
    func present<Content: View>(isPresented: Binding<Bool>, with style: UIModalPresentationStyle, given transDelegate: UIViewControllerTransitioningDelegate, content: @escaping () -> Content) -> some View {
        modifier(PresentViewModiferUIKit(isPresented: isPresented, with: style, given: transDelegate, sheet: content))
    }
}
