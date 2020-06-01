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
    private let delegate: UIViewControllerTransitioningDelegate?
    
    
    init(isPresented : Binding<Bool>, with style: UIModalPresentationStyle, given transDelegate: UIViewControllerTransitioningDelegate?, sheet: NewContent) {
        self._isPresented = isPresented
        self.sheet = sheet
        self.style = style
        self.delegate = transDelegate
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
                    controller.present(style: self.style, transDelegate: self.delegate) {
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
        modifier(_ModalPresentUIKit(isPresented: isPresented, with: style, given: nil, sheet: content()))
    }
    
    func present<Content: View>(isPresented: Binding<Bool>, with transDelegate: UIViewControllerTransitioningDelegate, content: @escaping () -> Content) -> some View {
        modifier(_ModalPresentUIKit(isPresented: isPresented, with: .custom, given: transDelegate, sheet: content()))
    }
    
    func present<Content: View>(isPresented: Binding<Bool>, with style: UIModalPresentationStyle, given transDelegate: UIViewControllerTransitioningDelegate, content: @escaping () -> Content) -> some View {
        modifier(_ModalPresentUIKit(isPresented: isPresented, with: style, given: transDelegate, sheet: content()))
    }
}
