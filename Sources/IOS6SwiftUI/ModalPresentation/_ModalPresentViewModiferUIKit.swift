//
//  _ModalPresentViewModiferUIKit.swift
//  IOS6
//
//  Created by Xuan Li on 5/16/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct _ModalPresentViewModiferUIKit<NewContent: View>: ViewModifier {
    @Environment(\._viewController) private var viewController
    @Binding private var isPresented: Bool
    
    private let sheet: NewContent
    private let style: UIModalPresentationStyle
    private let delegate: UIViewControllerTransitioningDelegate?
    
    init(isPresented : Binding<Bool>, with style: UIModalPresentationStyle, given transDelegate: UIViewControllerTransitioningDelegate?, sheet: @escaping () -> NewContent) {
        self._isPresented = isPresented
        self.sheet = sheet()
        self.style = style
        self.delegate = transDelegate
    }
    
    func body(content: Content) -> some View {
        content
            .preference(key: _ModalPresentKey.self, value: isPresented)
            .onPreferenceChange(_ModalPresentKey.self) { show in
                if show, !self.isShown {
                    self.viewController?.present(style: self.style, transDelegate: self.delegate) {
                        self.sheet
                            .environment(\.presentMode, PresentMode {
                                self.viewController?.dismiss(animated: true, completion: { self.isPresented = false })
                            })
                            .onDisappear {
                                if !self.isShown, self.isPresented {
                                    self.isPresented = false
                                }
                        }
                    }
                } else if !show, self.isShown {
                    self.viewController?.dismiss(animated: true, completion: nil)
                }
        }
    }
    
    private var isShown: Bool {
        viewController?.presentedViewController != nil
    }
}

struct PresentViewModiferCustom_Previews: PreviewProvider {
    static var previews: some View {
        Text("test")
            .present(isPresented: .constant(true), with: PartialSheetTransitioningDelegate(from: true, to: true)) {
                Text("Model")
        }
    }
}

public extension View {
    func present<Content: View>(isPresented: Binding<Bool>, with style: UIModalPresentationStyle, content: @escaping () -> Content) -> some View {
        modifier(_ModalPresentViewModiferUIKit(isPresented: isPresented, with: style, given: nil, sheet: content))
    }
    
    func present<Content: View>(isPresented: Binding<Bool>, with transDelegate: UIViewControllerTransitioningDelegate, content: @escaping () -> Content) -> some View {
        modifier(_ModalPresentViewModiferUIKit(isPresented: isPresented, with: .custom, given: transDelegate, sheet: content))
    }
    
    func present<Content: View>(isPresented: Binding<Bool>, with style: UIModalPresentationStyle, given transDelegate: UIViewControllerTransitioningDelegate, content: @escaping () -> Content) -> some View {
        modifier(_ModalPresentViewModiferUIKit(isPresented: isPresented, with: style, given: transDelegate, sheet: content))
    }
}
