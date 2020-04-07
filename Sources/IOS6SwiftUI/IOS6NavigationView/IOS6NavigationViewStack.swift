//
//  IOS6NavigationViewStack.swift
//  animation
//
//  Created by Xuan Li on 1/25/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

class IOS6NavigationViewStack: ObservableObject {
    @Published var stack = [EquatableView<AnyView>]()
    var titleStack = [String]()
    var boolStack = [Binding<Bool>]()
    @Published var offsetStack = [CGFloat]()
    
    init<Content: View>(rootView: Content, title: String) {
        stack.append(EquatableView(content: AnyView(rootView)))
        titleStack.append(title)
        offsetStack.append(0)
    }
    
    func count() -> Int {
        return stack.count
    }
    
    func item(of index: Int) -> EquatableView<AnyView> {
        if index >= stack.count {
            return EquatableView(content:  AnyView(Text("View Stack Index of \(index) exceed the maxmium count: \(stack.count)")))
        }
        return stack[index]
    }
    
    func push<Content: View>(isPresent: Binding<Bool>, title: String, newView: Content) {
        titleStack.append(title)
        boolStack.append(isPresent)
        let newTabView = EquatableView(content:  AnyView(newView.frame(maxWidth: .infinity, maxHeight: .infinity)))
        
        withAnimation(Animation.easeInOut(duration: 0.35).delay(0.15)) {
            self.stack.append(newTabView)
            self.offsetStack[self.offsetStack.count - 1] = -UIScreen.main.bounds.width
            self.offsetStack.append(0)
        }
    }
    
    func pop(scale: Double = 1) {
        if stack.count > 1 {
            withAnimation(Animation.easeInOut(duration: 0.35 * scale)) {
                stack.removeLast()
                titleStack.removeLast()
                offsetStack.removeLast()
                offsetStack[offsetStack.count - 1] = 0
            }
            withAnimation(.easeIn(duration: 0.35 * scale + 0.15)) {
                boolStack.removeLast().wrappedValue = false
            }
        }
    }
    
    func pick() -> EquatableView<AnyView> {
        return stack.last ?? EquatableView(content: AnyView(Text("Empty View Stack")))
    }
    
    func updateOffset(newOffset: CGFloat) {
        offsetStack[offsetStack.count - 1] = newOffset
        offsetStack[offsetStack.count - 2] = newOffset - UIScreen.main.bounds.width
    }
}

extension AnyView: Equatable {
    public static func == (lhs: AnyView, rhs: AnyView) -> Bool {
        return true
    }
}
