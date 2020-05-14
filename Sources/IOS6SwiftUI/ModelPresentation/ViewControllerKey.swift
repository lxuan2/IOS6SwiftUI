//
//  Environment.swift
//  animation
//
//  Created by Xuan Li on 1/27/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

public struct ViewControllerHolder {
    weak var value: UIViewController?
}

public struct ViewControllerKey: EnvironmentKey {
    public static var defaultValue: ViewControllerHolder {
        return ViewControllerHolder(value: UIApplication.shared.windows.first?.rootViewController)
    }
}

public extension EnvironmentValues {
    var viewController: UIViewController? {
        get { return self[ViewControllerKey.self].value }
        set { self[ViewControllerKey.self].value = newValue }
    }
}

public extension UIViewController {
    func present<Content: View>(with animation: Animation? = .default, @ViewBuilder builder: @escaping () -> Content) {
        let toPresent = UIHostingController(rootView: ModelView(content: builder, animation: .easeIn).environment(\.viewController, nil))
        toPresent.modalPresentationStyle = .overCurrentContext
        toPresent.view.isOpaque = true
        toPresent.view.backgroundColor = .clear
        toPresent.rootView = ModelView(content: builder, animation: animation).environment(\.viewController, toPresent)
        present(toPresent, animated: false, completion: nil)
    }
    
    func present<Content: View>(@ViewBuilder builder: @escaping () -> Content) {
        let toPresent = UIHostingController(rootView: builder().environment(\.viewController, nil))
        toPresent.modalPresentationStyle = .overCurrentContext
        toPresent.view.isOpaque = true
        toPresent.view.backgroundColor = .clear
        toPresent.rootView = builder().environment(\.viewController, toPresent)
        present(toPresent, animated: false, completion: nil)
    }
}

struct ModelView<Content: View>: View {
    @State private var show: Bool = false
    @Environment(\.viewController) var viewController
    let content: () -> Content
    let animation: Animation?
    
    var body: some View {
        ZStack {
            Spacer()
                .onAppear {
                    withAnimation(self.animation) {
                        self.show = true
                    }
            }
            if show {
                content()
                    .environment(\.presentMode, .constant(PresentMode(show: $show)))
                    .onDisappear {
                        self.viewController?.dismiss(animated: false, completion: nil)
                }
            }
        }
    }
}
