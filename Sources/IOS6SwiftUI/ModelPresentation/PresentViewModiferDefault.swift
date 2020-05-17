//
//  DefaultPresentViewModifer.swift
//  IOS6
//
//  Created by Xuan Li on 5/14/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct PresentViewModiferDefault<NewContent: View>: ViewModifier {
    @Environment(\.viewController) private var viewController
    @Binding var isPresented: Bool
    @State private var allow: Bool = false
    
    let sheet: NewContent
    let style: UIModalPresentationStyle
    
    init(isPresented : Binding<Bool>, with style: UIModalPresentationStyle, sheet: @escaping () -> NewContent) {
        self._isPresented = isPresented
        self.sheet = sheet()
        self.style = style
        handlePresent()
    }
    
    func body(content: Content) -> some View {
        handlePresent()
        return content.onAppear {
            if !self.allow {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.allow = true
                    if self.isPresented {}
                }
            }
        }
    }
    
    func handlePresent() {
        if allow {
            if isPresented, viewController?.presentedViewController == nil {
                viewController?.present(style: style) {
                    self.sheet
                        .environment(\.presentMode, PresentMode(show: self.$isPresented) {
                            self.viewController?.dismiss(animated: true, completion: nil)
                        })
                        .onDisappear {
                            if self.isPresented {
                                self.isPresented = false
                            }
                    }
                }
            } else if !isPresented, viewController?.presentedViewController != nil {
                viewController?.dismiss(animated: true, completion: nil)
            }
        }
    }
}

struct DefaultPresentViewModifer_Previews: PreviewProvider {
    static var previews: some View {
        Text("test")
            .present(isPresented: .constant(true), with: .automatic) {
                Text("Model")
        }
    }
}
