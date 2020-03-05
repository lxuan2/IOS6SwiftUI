//
//  Environment.swift
//  animation
//
//  Created by Xuan Li on 1/27/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct ViewControllerHolder {
    weak var value: UIViewController?
}

struct ViewControllerKey: EnvironmentKey {
    static var defaultValue: ViewControllerHolder {
        return ViewControllerHolder(value: UIApplication.shared.windows.first?.rootViewController)

    }
}

extension EnvironmentValues {
    var viewController: UIViewController? {
        get { return self[ViewControllerKey.self].value }
        set { self[ViewControllerKey.self].value = newValue }
    }
}

var detailsTransitioningDelegate: InteractiveModalTransitioningDelegate!

extension UIViewController {
    func present<Content: View>(style: UIModalPresentationStyle = .automatic, @ViewBuilder builder: () -> Content) {
        let toPresent = UIHostingController(rootView: AnyView(EmptyView()))
        toPresent.modalPresentationStyle = .custom
        detailsTransitioningDelegate = InteractiveModalTransitioningDelegate(from: true, to: true)
        toPresent.transitioningDelegate = detailsTransitioningDelegate
        toPresent.rootView = AnyView(
            builder()
                .environment(\.viewController, toPresent)
        )
        self.present(toPresent, animated: true, completion: nil)
    }
}

final class InteractiveModalTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    var interactiveDismiss = true
    
    init(from presented: Bool, to presenting: Bool) {
        super.init()
    }
    
    // MARK: - UIViewControllerTransitioningDelegate
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return InteractiveModalPresentationController(presentedViewController: presented, presenting: presenting)
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return nil
    }
    
}

enum ModalScaleState {
    case presentation
    case interaction
}

final class InteractiveModalPresentationController: UIPresentationController {
    
    private let presentedYOffset: CGFloat = 150
    private var direction: CGFloat = 0
    private var state: ModalScaleState = .interaction
    private lazy var dimmingView: UIView! = {
        guard let container = containerView else { return nil }
        
        let view = UIView(frame: container.bounds)
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        view.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(didTap(tap:)))
        )
        
        return view
    }()
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        
//        presentedViewController.view.addGestureRecognizer(
//            UIPanGestureRecognizer(target: self, action: #selector(didPan(pan:)))
//        )
    }
    
//    @objc func didPan(pan: UIPanGestureRecognizer) {
//        guard let view = pan.view, let superView = view.superview,
//            let presented = presentedView, let container = containerView else { return }
//
//        let location = pan.translation(in: superView)
//
//        switch pan.state {
//        case .began:
//            presented.frame.size.height = container.frame.height
//        case .changed:
//            let velocity = pan.velocity(in: superView)
//
//            switch state {
//            case .interaction:
//                presented.frame.origin.y = location.y + presentedYOffset
//            case .presentation:
//                presented.frame.origin.y = location.y
//            }
//            direction = velocity.y
//        case .ended:
//            let maxPresentedY = container.frame.height - presentedYOffset
//            switch presented.frame.origin.y {
//            case 0...maxPresentedY:
//                changeScale(to: .interaction)
//            default:
//                presentedViewController.dismiss(animated: true, completion: nil)
//            }
//        default:
//            break
//        }
//    }
    
    @objc func didTap(tap: UITapGestureRecognizer) {
        presentedViewController.dismiss(animated: true, completion: nil)
    }
    
//    func changeScale(to state: ModalScaleState) {
//        guard let presented = presentedView else { return }
//
//        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: { [weak self] in
//            guard let `self` = self else { return }
//
//            presented.frame = self.frameOfPresentedViewInContainerView
//
//            }, completion: { (isFinished) in
//                self.state = state
//        })
//    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let container = containerView else { return .zero }
        
        return CGRect(x: 0, y: self.presentedYOffset, width: container.bounds.width, height: container.bounds.height - self.presentedYOffset)
    }
    
    override func presentationTransitionWillBegin() {
        guard let container = containerView,
            let coordinator = presentingViewController.transitionCoordinator else { return }
        
        dimmingView.alpha = 0
        container.addSubview(dimmingView)
        dimmingView.addSubview(presentedViewController.view)
        
        coordinator.animate(alongsideTransition: { [weak self] context in
            guard let `self` = self else { return }
            
            self.dimmingView.alpha = 1
            }, completion: nil)
    }
    
    override func dismissalTransitionWillBegin() {
        guard let coordinator = presentingViewController.transitionCoordinator else { return }
        
        coordinator.animate(alongsideTransition: { [weak self] (context) -> Void in
            guard let `self` = self else { return }
            
            self.dimmingView.alpha = 0
            }, completion: nil)
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed {
            dimmingView.removeFromSuperview()
        }
    }
    
}
