//
//  IOS6NavigationViewStack.swift
//  animation
//
//  Created by Xuan Li on 1/25/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI
import Combine

class IOS6NavigationViewStack: ObservableObject {
    @Published var blocking = false
    @Published var dragAmount: CGFloat = 0
    @Published var stack = [IOS6NavigationPage]()
    var boolStack = [Binding<Bool>]()
    var titleStack = [String]()
    let standardTime: Double = 0.35
    
    init<Content: View>(rootView: Content, title: String) {
        stack.append(IOS6NavigationPage(page: rootView))
        titleStack.append(title)
    }
    
    func push<Content: View>(isPresent: Binding<Bool>, title: String, newView: Content) {
        
        titleStack.append(title)
        boolStack.append(isPresent)
        blocking = true
        DispatchQueue.main.asyncAfter(deadline: .now() + standardTime + 0.15 + 0.1) {
            self.blocking = false
        }
        
        withAnimation(Animation.easeInOut(duration: standardTime).delay(0.15)) {
            self.stack.append(IOS6NavigationPage(page: newView.frame(maxWidth: .infinity, maxHeight: .infinity)))
        }
    }
    
    func pop() {
        if stack.count > 1 {
            blocking = true
            DispatchQueue.main.asyncAfter(deadline: .now() + standardTime + 0.15 + 0.1) {
                self.blocking = false
            }
            withAnimation(Animation.easeInOut(duration: standardTime)) {
                dragAmount = 0
                stack.removeLast()
                titleStack.removeLast()
            }
            withAnimation(.easeIn(duration: standardTime + 0.15)) {
                boolStack.removeLast().wrappedValue = false
            }
        }
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
                let time = standardTime * Double((proxy.size.width - value.translation.width)/proxy.size.width)
                withAnimation(Animation.easeInOut(duration: time)) {
                    dragAmount = proxy.size.width
                }
                withAnimation(.easeIn(duration: time + 0.15)) {
                    boolStack.removeLast().wrappedValue = false
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + time + 0.15 + 0.1) {
                    self.blocking = false
                    self.stack.removeLast()
                    self.titleStack.removeLast()
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

struct IOS6NavigationPage: UIViewControllerRepresentable {
    
    let content: UIViewController
    
    init<Page: View>(page: Page) {
        content = UIHostingController(rootView: page)
        content.modalPresentationStyle = .overCurrentContext
        content.view.backgroundColor = UIColor.clear
        content.view.isOpaque = false
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        return content
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
}
