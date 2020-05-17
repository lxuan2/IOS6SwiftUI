//
//  PresentViewModifer.swift
//  IOS6
//
//  Created by Xuan Li on 5/13/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct PresentViewModifer<NewContent: View>: ViewModifier {
    @Environment(\.viewController) private var viewController
    @Binding var isPresented: Bool
    @State private var allow: Bool = false
    
    let sheet: NewContent
    let animation: Animation?
    
    init(isPresented : Binding<Bool>, with animation: Animation? = .default, sheet: @escaping () -> NewContent) {
        self._isPresented = isPresented
        self.sheet = sheet()
        self.animation = animation
    }
    
    func body(content: Content) -> some View {
        if isPresented, viewController?.presentedViewController == nil, allow {
            self.viewController?.present {
                ModalCoodinatorView(show: self.$isPresented, content: self.sheet, animation: self.animation)
            }
        }
        return content.onAppear {
            if !self.allow {
                if self.isPresented {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.allow = true
                    }
                } else {
                    self.allow = true
                }
            }
        }
    }
}

struct PresentViewModifer_Previews: PreviewProvider {
    static var previews: some View {
        Text("test")
            .present(isPresented: .constant(true), with: .easeInOut(duration: 0.5)) {
                ZStack {
                    Color.white
                        .edgesIgnoringSafeArea(.all)
                        .zIndex(0)
                    Text("Model")
                        .zIndex(1)
                }.transition(.move(edge: .bottom))
        }
    }
}

struct ModalCoodinatorView<Content: View>: View {
    @State private var localShow: Bool = false
    @Environment(\.viewController) private var viewController
    
    @Binding var show: Bool
    let content: Content
    let animation: Animation?
    
    var body: some View {
        ZStack {
            Spacer()
            
            if show {
                Spacer()
                    .onAppear {
                        withAnimation(self.animation) {
                            self.localShow = true
                        }
                }
                .onDisappear {
                    withAnimation(self.animation) {
                        self.localShow = false
                    }
                }
            }
            
            if localShow {
                content
                    .environment(\.presentMode, PresentMode(show: $show))
                    .onDisappear {
                        self.viewController?.dismiss(animated: false, completion: nil)
                }
            }
        }
    }
}
