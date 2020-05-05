//
//  IOS6NavigationViewStack.swift
//  animation
//
//  Created by Xuan Li on 1/25/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI
import Combine

class IOS6NavigationStack: ObservableObject {
    
    @Published private(set) var blocking = false
    @Published private(set) var dragAmount: CGFloat = 0
    @Published private(set) var stack = [IOS6NavigationPageView]()
    @Published private(set) var barStack: [String?] = [String?]()
    
    init<Content: View>(rootView: Content) {
        stack.append(IOS6NavigationPageView(page: rootView))
        barStack.append(nil)
        DispatchQueue.main.async {
            self.objectWillChange.send()
        }
    }
    
    func push<Content: View>(isPresent: Binding<Bool>, newView: () -> Content) {
        // Lock
        blocking = true
        
        withAnimation(Animation.easeInOut(duration: IOS6NavigationStack.standardTime).delay(0.15)) {
            let extendedView = newView()
            self.stack.append(IOS6NavigationPageView(page: extendedView, previousPageLock: isPresent))
            self.barStack.append(nil)
        }
        
        // Unlock
        DispatchQueue.main.asyncAfter(deadline: .now() + IOS6NavigationStack.standardTime + 0.15 + 0.1) {
            self.blocking = false
        }
    }
    
    func pop() {
        if stack.count > 1 {
            // Lock
            blocking = true
            
            var isLastPageSelected: Binding<Bool>? = nil
            withAnimation(Animation.easeInOut(duration: IOS6NavigationStack.standardTime)) {
                dragAmount = 0
                isLastPageSelected = stack.removeLast().lock
                barStack.removeLast()
            }
            withAnimation(.easeIn(duration: IOS6NavigationStack.standardTime + 0.15)) {
                isLastPageSelected?.wrappedValue = false
            }
            
            // Unlock
            DispatchQueue.main.asyncAfter(deadline: .now() + IOS6NavigationStack.standardTime + 0.15 + 0.1) {
                self.blocking = false
            }
        }
    }
    
    func updateTitle(at index: Int, with title: String?) {
        barStack[index] = title
    }
    
    func updateOffset(with value: DragGesture.Value) {
        if stack.count > 1 {
            if dragAmount != value.translation.width {
                dragAmount = value.translation.width
                blocking = true
            }
        }
    }
    
    func endOffset(with value: DragGesture.Value, in proxy: GeometryProxy)  {
        if stack.count > 1 {
            let half =  proxy.size.width / 2
            if value.predictedEndTranslation.width > half || value.translation.width > half  {
                let time = IOS6NavigationStack.standardTime * Double((proxy.size.width - value.translation.width)/proxy.size.width)
                withAnimation(Animation.easeInOut(duration: time)) {
                    dragAmount = proxy.size.width
                }
                let isLastPageSelected: Binding<Bool>? = stack.last?.lock
                withAnimation(.easeIn(duration: time + 0.15)) {
                    isLastPageSelected?.wrappedValue = false
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + time + 0.15 + 0.1) {
                    self.blocking = false
                    self.stack.removeLast()
                    self.dragAmount = 0
                }
            } else {
                withAnimation(Animation.easeInOut(duration: 0.2)) {
                    dragAmount = 0
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2 + 0.1) {
                    self.blocking = false
                }
            }
        }
    }
}

extension IOS6NavigationStack: RandomAccessCollection {
    typealias Element = IOS6NavigationPageView
    
    var startIndex: Int { stack.startIndex }
    var endIndex: Int { stack.endIndex }
    
    subscript(position: Int) -> IOS6NavigationPageView {
        return stack[position]
    }
}

extension IOS6NavigationStack {
    func before(_ index: Int) -> String? {
        if index - 1 >= 0 {
            return barStack[index - 1]
        }
        return nil
    }
}

extension IOS6NavigationStack {
    private static let standardTime: Double = 0.35
}
