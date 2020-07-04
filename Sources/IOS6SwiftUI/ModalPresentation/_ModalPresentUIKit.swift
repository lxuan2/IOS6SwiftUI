//
//  _ModalPresentViewModiferUIKit.swift
//  IOS6
//
//  Created by Xuan Li on 5/16/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct _ModalPresentUIKit<NewContent: View>: ViewModifier {
    @Environment(\._viewController) private var viewController
    @Binding private var isPresented: Bool
    @State private var vc: _ViewControllerHolder = _ViewControllerHolder(value: nil)
    
    private let sheet: NewContent
    private let style: UIModalPresentationStyle
    private let transDelegate: UIViewControllerTransitioningDelegate?
    private let adaptDelegate: UIAdaptivePresentationControllerDelegate?
    
    init(isPresented : Binding<Bool>, with style: UIModalPresentationStyle, given transDelegate: UIViewControllerTransitioningDelegate?, onDismissAttempt: (() -> Void)?, allowDismiss: Binding<Bool>, sheet: NewContent) {
        self._isPresented = isPresented
        self.sheet = sheet
        self.style = style
        self.transDelegate = transDelegate
        self.adaptDelegate = AdaptiveDelegate(onDismissAttempt: onDismissAttempt, allowDismiss: allowDismiss)
    }
    
    func body(content: Content) -> some View {
        content
            .preference(key: _ModalPresentKey.self, value: isPresented)
            .onPreferenceChange(_ModalPresentKey.self) { show in
                if show, !self.isShown {
                    var controller: UIViewController
                    if var ctl = self.viewController {
                        while ctl.presentedViewController != nil {
                            ctl = ctl.presentedViewController!
                        }
                        controller = ctl
                    } else { return }
                    controller.present(isHomeIndicatorHidden: true, style: self.style, transDelegate: self.transDelegate, adaptDelegate: self.adaptDelegate) {
                        self.sheet
                            .environment(\.ios6PresentationMode, IOS6PresentationMode {
                                if let ctler = self._vc.wrappedValue.value {
                                    _ModalPresentUIKit.removeChild(viewController: ctler)
                                }
                                self.vc.value = nil
                            })
                            .onDisappear {
                                if self._vc.wrappedValue.value?.presentedViewController?.presentedViewController != nil {
                                    return
                                }
                                self.isPresented = false
                        }
                    }
                    self.vc.value = controller
                } else if !show, self.isShown {
                    if let controller = self.vc.value {
                        _ModalPresentUIKit.removeChild(viewController: controller)
                    }
                    self.vc.value = nil
                }
        }
    }
    
    private var isShown: Bool {
        vc.value != nil
    }
    
    static func removeChild(viewController: UIViewController) {
        if viewController.presentedViewController != nil {
            if viewController.presentedViewController!.presentedViewController != nil {
                removeChild(viewController: viewController.presentedViewController!)
            }
            viewController.dismiss(animated: true, completion: nil)
        }
    }
    
    class AdaptiveDelegate: NSObject, UIAdaptivePresentationControllerDelegate {
        var onDismissAttempt: (() -> Void)?
        var allowDismiss: Binding<Bool>
        
        init(onDismissAttempt: (() -> Void)?, allowDismiss: Binding<Bool>) {
            self.onDismissAttempt = onDismissAttempt
            self.allowDismiss = allowDismiss
        }
        
        func presentationControllerDidAttemptToDismiss(_ presentationController: UIPresentationController) {
            if let attempt = onDismissAttempt {
                attempt()
            }
        }
        
        func presentationControllerShouldDismiss(_ presentationController: UIPresentationController) -> Bool {
            allowDismiss.wrappedValue
        }
    }
}

struct PresentViewModiferCustom_Previews: PreviewProvider {
    static var previews: some View {
        Text("test")
            .present(isPresented: .constant(true), given: PartialSheetTransitioningDelegate(from: true, to: true)) {
                Text("Model")
        }
    }
}

public extension View {
    func present<Content: View>(isPresented: Binding<Bool>, with style: UIModalPresentationStyle, content: () -> Content) -> some View {
        modifier(_ModalPresentUIKit(isPresented: isPresented, with: style, given: nil, onDismissAttempt: nil, allowDismiss: .constant(true), sheet: content()))
    }

    func present<Content: View>(isPresented: Binding<Bool>, given transDelegate: UIViewControllerTransitioningDelegate, content: @escaping () -> Content) -> some View {
        modifier(_ModalPresentUIKit(isPresented: isPresented, with: .custom, given: transDelegate, onDismissAttempt: nil, allowDismiss: .constant(true), sheet: content()))
    }

    func present<Content: View>(isPresented: Binding<Bool>, isDismissable: Binding<Bool>, onDismissAttempt: (() -> Void)? = nil, content: () -> Content) -> some View {
        modifier(_ModalPresentUIKit(isPresented: isPresented, with: .pageSheet, given: nil, onDismissAttempt: onDismissAttempt, allowDismiss: isDismissable, sheet: content()))
    }
}
