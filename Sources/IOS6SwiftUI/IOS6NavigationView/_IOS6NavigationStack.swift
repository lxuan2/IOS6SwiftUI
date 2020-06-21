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
    @Published private(set) var stack = [_IOS6NavigationPageView]()
    @Published private(set) var barStack: [String?] = [String?]()
    @Published private(set) var offsetStack: [CGFloat] = [CGFloat]()
    
    init<Content: View>(rootView: Content) {
        stack.append(_IOS6NavigationPageView(page: rootView, index: 0))
        barStack.append(nil)
        offsetStack.append(0)
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
        stack.append(_IOS6NavigationPageView(page: extendedView, index: index, previousPageLock: isPresent))
        barStack.append(nil)
        offsetStack.append(1)
    }
    
    func pop(to pageIndex: Int?  = nil) {
        if count > 1 {
            
            // Unwrap index and check validation
            if let _pageIndex = pageIndex {
                
                // Out of range
                if _pageIndex <= 0 || _pageIndex > count - 1 {
                    return
                }
                
                // Remove items before the given index
                if _pageIndex != count - 1 {
                    let range = _pageIndex..<(count - 1)
                    stack.removeSubrange(range)
                    barStack.removeSubrange(range)
                    offsetStack.removeSubrange(range)
                }
            }
            
            // Lock
            blocking = true
            let index = count - 1
            let lock = stack[index].lock
            
            // Remove last view with animation
            withAnimation(.easeIn(duration: _IOS6NavigationStack.unselectedTime + _IOS6NavigationStack.standardTime)) {
                lock?.wrappedValue = false
            }
            
            withAnimation(.easeInOut(duration: _IOS6NavigationStack.standardTime)) {
                let prevIndex = stack.count - 2
                if prevIndex >= 0 {
                    offsetStack[prevIndex] = 0
                }
                stack.removeLast()
                barStack.removeLast()
                offsetStack.removeLast()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + _IOS6NavigationStack.unselectedTime + _IOS6NavigationStack.standardTime) {
                self.blocking = false
            }
        }
    }
    
    func transIn(_ index: Int) {
        if blocking == true {
            withAnimation(Animation.easeInOut(duration: _IOS6NavigationStack.standardTime).delay(_IOS6NavigationStack.unselectedTime)) {
                offsetStack[index] = 0
                let prevIndex = index - 1
                if prevIndex >= 0 {
                    offsetStack[prevIndex] = -1
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + _IOS6NavigationStack.standardTime + _IOS6NavigationStack.unselectedTime) {
                self.blocking = false
            }
        }
    }
    
    func updateTitle(at index: Int, with title: String?) {
        barStack[index] = title
    }
    
    func updateOffset(_ _value: CGFloat) {
        if stack.count > 1 {
            let value = _value.threshold(0, 1)
            let index = count - 1
            if offsetStack[index] != value {
                offsetStack[index] = value
                offsetStack[index - 1] = value - 1
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
                let time = _IOS6NavigationStack.standardTime * Double(1 - value.translation.width / proxy.size.width)
                let lock = stack[count - 1].lock
                
                withAnimation(.easeIn(duration: _IOS6NavigationStack.unselectedTime + time)) {
                    lock?.wrappedValue = false
                }
                
                withAnimation(.easeInOut(duration: time)) {
                    stack.removeLast()
                    barStack.removeLast()
                    offsetStack.removeLast()
                    offsetStack[count - 1] = 0
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + _IOS6NavigationStack.unselectedTime + time) {
                    self.blocking = false
                }
            } else {
                withAnimation(Animation.easeInOut(duration: 0.2)) {
                    offsetStack[count - 1] = 0
                    offsetStack[count - 2] = -1
                }
                // Unlock
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
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
    static let standardTime: Double = 0.35
    private static let unselectedTime: Double = 0.15
}

extension CGFloat {
    func threshold(_ minValue: CGFloat, _ maxValue: CGFloat) -> CGFloat {
        if maxValue <= minValue {
            return -1
        }
        return Swift.min(maxValue, Swift.max(minValue, self))
    }
}
