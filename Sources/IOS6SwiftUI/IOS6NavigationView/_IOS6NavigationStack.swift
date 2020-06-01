//
//  IOS6NavigationViewStack.swift
//  animation
//
//  Created by Xuan Li on 1/25/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

class _IOS6NavigationStack: ObservableObject {
    
    @Published private(set) var blocking = false
    @Published private(set) var dragAmount: CGFloat = 0
    @Published private(set) var stack = [_IOS6NavigationPageView]()
    @Published private(set) var barStack: [String?] = [String?]()
    
    init<Content: View>(rootView: Content) {
        stack.append(_IOS6NavigationPageView(page: rootView, index: 0))
        barStack.append(nil)
        DispatchQueue.main.async {
            self.objectWillChange.send()
        }
    }
    
    func push<Content: View>(isPresent: Binding<Bool>, newView: Content) {
        // Lock
        blocking = true
        
        let index = count
        let extendedView = newView
            .environment(\.ios6PresentationMode, IOS6PresentationMode{
                self.pop(to: index)
            })
        withAnimation(Animation.easeInOut(duration: _IOS6NavigationStack.standardTime).delay(_IOS6NavigationStack.unselectedTime)) {
            self.stack.append(_IOS6NavigationPageView(page: extendedView, index: index, previousPageLock: isPresent))
            self.barStack.append(nil)
        }
        
        // Unlock
        DispatchQueue.main.asyncAfter(deadline: .now() + _IOS6NavigationStack.standardTime + _IOS6NavigationStack.unselectedTime + 0.1) {
            self.blocking = false
        }
    }
    
    func pop(to pageIndex: Int?  = nil) {
        if stack.count > 1 {
            // Unwrap index and check validation
            let lastIndex = stack.count - 1
            let index = pageIndex == nil ? lastIndex : pageIndex!
            if index <= 0 || index > lastIndex {
                return
            }
            
            // Lock
            blocking = true
            
            // Remove views from before last to index
            let lock = stack[index].lock
            let range = index..<lastIndex
            stack.removeSubrange(range)
            barStack.removeSubrange(range)
            
            // Remove last view with animation
            withAnimation(Animation.easeIn(duration: _IOS6NavigationStack.unselectedTime + _IOS6NavigationStack.standardTime)) {
                lock?.wrappedValue = false
            }
            
            withAnimation(.easeInOut(duration: _IOS6NavigationStack.standardTime)) {
                dragAmount = 0
                stack.removeLast()
                barStack.removeLast()
            }
            
            // Unlock
            DispatchQueue.main.asyncAfter(deadline: .now() + _IOS6NavigationStack.standardTime + _IOS6NavigationStack.unselectedTime) {
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
            // Lock
            self.blocking = true
            
            let half =  proxy.size.width / 2
            if value.predictedEndTranslation.width > half || value.translation.width > half  {
                let time = _IOS6NavigationStack.standardTime * Double((proxy.size.width - value.translation.width)/proxy.size.width)
                withAnimation(Animation.easeIn(duration: _IOS6NavigationStack.unselectedTime + time)) {
                    stack.last?.lock?.wrappedValue = false
                }
                withAnimation(Animation.easeInOut(duration: time)) {
                    dragAmount = 0
                    stack.removeLast()
                    barStack.removeLast()
                }
                // Unlock
                DispatchQueue.main.asyncAfter(deadline: .now() + time + _IOS6NavigationStack.unselectedTime + 0.1) {
                    self.blocking = false
                }
            } else {
                withAnimation(Animation.easeInOut(duration: 0.2)) {
                    dragAmount = 0
                }
                // Unlock
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2 + 0.1) {
                    self.blocking = false
                }
            }
        }
    }
}

extension _IOS6NavigationStack: RandomAccessCollection {
    typealias Element = _IOS6NavigationPageView
    
    var startIndex: Int { stack.startIndex }
    var endIndex: Int { stack.endIndex }
    
    subscript(position: Int) -> _IOS6NavigationPageView {
        return stack[position]
    }
}

extension _IOS6NavigationStack {
    func before(_ index: Int) -> String? {
        if index - 1 >= 0 {
            return barStack[index - 1]
        }
        return nil
    }
}

extension _IOS6NavigationStack {
    private static let standardTime: Double = 0.35
    private static let unselectedTime: Double = 0.15
}
