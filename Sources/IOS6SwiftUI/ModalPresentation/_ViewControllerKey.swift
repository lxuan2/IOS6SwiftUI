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
    
    func present<Content: View>(builder: @escaping () -> Content) {
        let toPresent = UIHostingController(rootView: builder().environment(\._viewController, nil))
        toPresent.modalPresentationStyle = .overFullScreen
        toPresent.view.isOpaque = true
        toPresent.view.backgroundColor = .clear
        toPresent.rootView = builder().environment(\._viewController, toPresent)
        present(toPresent, animated: false, completion: nil)
    }
    
    func present<Content: View>(style: UIModalPresentationStyle = .automatic, transDelegate: UIViewControllerTransitioningDelegate? = nil, builder: @escaping () -> Content) {
        let toPresent = UIHostingController(rootView: builder().environment(\._viewController, nil))
        toPresent.modalPresentationStyle = style
        toPresent.transitioningDelegate = transDelegate
        toPresent.rootView = builder().environment(\._viewController, toPresent)
        present(toPresent, animated: true, completion: nil)
    }
}
