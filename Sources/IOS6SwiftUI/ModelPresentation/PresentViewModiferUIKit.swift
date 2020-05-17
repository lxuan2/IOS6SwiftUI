//
//  PresentViewModiferCustom.swift
//  IOS6
//
//  Created by Xuan Li on 5/16/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct PresentViewModiferUIKit<NewContent: View>: ViewModifier {
    @Environment(\.viewController) private var viewController
    @Binding var isPresented: Bool
    
    let sheet: NewContent
    let style: UIModalPresentationStyle
    let delegate: UIViewControllerTransitioningDelegate?
    
    init(isPresented : Binding<Bool>, with style: UIModalPresentationStyle, given transDelegate: UIViewControllerTransitioningDelegate?, sheet: @escaping () -> NewContent) {
        self._isPresented = isPresented
        self.sheet = sheet()
        self.style = style
        self.delegate = transDelegate
    }
    
    func body(content: Content) -> some View {
        content
            .preference(key: PresentationKey.self, value: isPresented)
            .onPreferenceChange(PresentationKey.self) { show in
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
    
    var isShown: Bool {
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
