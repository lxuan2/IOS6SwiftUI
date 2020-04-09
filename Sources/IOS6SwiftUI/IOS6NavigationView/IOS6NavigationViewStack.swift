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
    @Published var blocking = false
    
    init<Content: View>(rootView: Content, title: String) {
        stack.append(EquatableView(content: AnyView(rootView)))
        titleStack.append(title)
    }
    
    func push<Content: View>(isPresent: Binding<Bool>, title: String, newView: Content) {
        titleStack.append(title)
        boolStack.append(isPresent)
        let newTabView = EquatableView(content: AnyView(newView.frame(maxWidth: .infinity, maxHeight: .infinity)))
        blocking = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5 + 0.1) {
            
            self.blocking = false
        }
        
        withAnimation(Animation.easeInOut(duration: 0.35).delay(0.15)) {
            self.stack.append(newTabView)
        }
    }
    
    func pop(scale: Double = 1) {
        if stack.count > 1 {
            //UITableView.appearance().showsVerticalScrollIndicator = false
            blocking = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.35 * scale + 0.15 + 0.1) {
                self.blocking = false
            }
            
            withAnimation(Animation.easeInOut(duration: 0.35 * scale)) {
                stack.removeLast()
                titleStack.removeLast()
            }
            withAnimation(.easeIn(duration: 0.35 * scale + 0.15)) {
                boolStack.removeLast().wrappedValue = false
            }
        }
    }
}

extension AnyView: Equatable {
    public static func == (lhs: AnyView, rhs: AnyView) -> Bool {
        return true
    }
}
