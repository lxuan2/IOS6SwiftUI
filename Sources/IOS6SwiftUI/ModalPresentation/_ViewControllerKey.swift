//
//  Environment.swift
//  animation
//
//  Created by Xuan Li on 1/27/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct _ViewControllerHolder {
    weak var value: UIViewController?
}

struct _ViewControllerKey: EnvironmentKey {
    static var defaultValue: _ViewControllerHolder {
        return _ViewControllerHolder(value: UIApplication.shared.windows.first?.rootViewController)
    }
}

extension EnvironmentValues {
    var _viewController: UIViewController? {
        get { return self[_ViewControllerKey.self].value }
        set { self[_ViewControllerKey.self].value = newValue }
    }
}

extension UIViewController {
    func present<Content: View>(isHomeIndicatorHidden: Bool = false, builder: @escaping () -> Content) {
        let toPresent = _IOS6ModalViewController(rootView: builder().environment(\._viewController, nil))
        toPresent.isHomeIndicatorHidden = isHomeIndicatorHidden
        toPresent.modalPresentationStyle = .overFullScreen
        toPresent.view.isOpaque = true
        toPresent.view.backgroundColor = .clear
        toPresent.rootView = builder().environment(\._viewController, toPresent)
        present(toPresent, animated: false, completion: nil)
    }
    
    func present<Content: View>(isHomeIndicatorHidden: Bool = false, style: UIModalPresentationStyle = .automatic, transDelegate: UIViewControllerTransitioningDelegate? = nil, adaptDelegate: UIAdaptivePresentationControllerDelegate? = nil, builder: @escaping () -> Content) {
        let toPresent = _IOS6ModalViewController(rootView: builder().environment(\._viewController, nil))
        toPresent.isHomeIndicatorHidden = isHomeIndicatorHidden
        toPresent.modalPresentationStyle = style
        toPresent.transitioningDelegate = transDelegate
        toPresent.presentationController?.delegate = adaptDelegate
        toPresent.rootView = builder().environment(\._viewController, toPresent)
        present(toPresent, animated: true, completion: nil)
    }
}

class _IOS6ModalViewController<Content: View>: UIHostingController<Content> {
    var isHomeIndicatorHidden: Bool = false
    
    override var prefersHomeIndicatorAutoHidden: Bool {
        isHomeIndicatorHidden
    }
}
