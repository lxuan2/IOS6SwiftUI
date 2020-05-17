//
//  UIViewControllerExtension.swift
//  IOS6
//
//  Created by Xuan Li on 5/14/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//
import UIKit
import SwiftUI

extension UIViewController {
    
    func present<Content: View>(builder: @escaping () -> Content) {
        let toPresent = UIHostingController(rootView: builder().environment(\.viewController, nil))
        toPresent.modalPresentationStyle = .overFullScreen
        toPresent.view.isOpaque = true
        toPresent.view.backgroundColor = .clear
        toPresent.rootView = builder().environment(\.viewController, toPresent)
        present(toPresent, animated: false, completion: nil)
    }
    
    func present<Content: View>(style: UIModalPresentationStyle = .automatic, transDelegate: UIViewControllerTransitioningDelegate? = nil, builder: @escaping () -> Content) {
        let toPresent = UIHostingController(rootView: builder().environment(\.viewController, nil))
        
        // Check if Delegate is enabled
        if transDelegate != nil {
            toPresent.modalPresentationStyle = .custom
            toPresent.transitioningDelegate = transDelegate
        } else {
            toPresent.modalPresentationStyle = style
        }
        
        toPresent.rootView = builder().environment(\.viewController, toPresent)
        present(toPresent, animated: true, completion: nil)
    }
}
