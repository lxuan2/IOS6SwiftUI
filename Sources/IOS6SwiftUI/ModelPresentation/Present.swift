//
//  Present.swift
//  IOS6
//
//  Created by Xuan Li on 5/14/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

public extension View {
    
    func present<Content: View>(isPresented: Binding<Bool>, with animation: Animation? = .default, @ViewBuilder content: @escaping () -> Content) -> some View {
        modifier(PresentViewModifer(isPresented: isPresented, with: animation, sheet: content))
    }
    
    func present<Content: View>(isPresented: Binding<Bool>, with style: UIModalPresentationStyle, content: @escaping () -> Content) -> some View {
        modifier(DefaultPresentViewModifer(isPresented: isPresented, with: style, sheet: content))
    }
}
