//
//  IOS6NavigationViewStack.swift
//  animation
//
//  Created by Xuan Li on 1/25/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

class IOS6NavigationViewStack: ObservableObject {
    @Published var stack = [AnyView]()
    var titleStack = [String]()
    var boolStack = [Binding<Bool>]()
    
    init<Content: View>(rootView: Content, title: String) {
        stack.append(AnyView(rootView))
        titleStack.append(title)
    }
    
    func count() -> Int {
        return stack.count
    }
    
    func item(of index: Int) -> AnyView {
        if index >= stack.count {
            return AnyView(Text("View Stack Index of \(index) exceed the maxmium count: \(stack.count)"))
        }
        return stack[index]
    }
    
    func push<Content: View>(isPresent: Binding<Bool>, title: String, newView: Content) {
        titleStack.append(title)
        boolStack.append(isPresent)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            withAnimation(.easeInOut(duration: 0.35)) {
                self.stack.append(AnyView(
                    newView
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .transition(.move(edge: .trailing))
                ))
            }
        }
    }
    
    func pop() {
        if stack.count > 1 {
            withAnimation(.easeInOut(duration: 0.35)) {
                stack.removeLast()
                titleStack.removeLast()
                
            }
            withAnimation(.easeIn(duration: 0.5)) {
                boolStack.removeLast().wrappedValue = false
            }
        }
    }
    
    func pick() -> AnyView {
        return stack.last ?? AnyView(Text("Empty View Stack"))
    }
}
