//
//  _ModalPresentViewModifer.swift
//  IOS6
//
//  Created by Xuan Li on 5/13/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct _ModalPresentViewModifer<NewContent: View>: ViewModifier {
    @Environment(\._viewController) private var viewController
    @Binding private var isPresented: Bool
    
    private let sheet: NewContent
    private let animation: Animation?
    
    init(isPresented : Binding<Bool>, with animation: Animation? = .default, sheet: @escaping () -> NewContent) {
        self._isPresented = isPresented
        self.sheet = sheet()
        self.animation = animation
    }
    
    func body(content: Content) -> some View {
        content
            .preference(key: _ModalPresentKey.self, value: isPresented)
            .onPreferenceChange(_ModalPresentKey.self) { show in
                if show, !self.isShown {
                    self.viewController?.present {
                        _PresentationView(show: self.$isPresented, content: self.configuredSheet, animation: self.animation)
                    }
                }
        }
    }
    
    private var configuredSheet: some View {
        sheet
            .compositingGroup()
            .environment(\.presentMode, PresentMode(show: self.$isPresented))
            .onDisappear {self.viewController?.dismiss(animated: false, completion: nil)}
    }
    
    private var isShown: Bool {
        viewController?.presentedViewController != nil
    }
    
    struct _PresentationView<Content: View>: View {
        @State private var localShow: Bool = false
        @Binding var show: Bool
        
        let content: Content
        let animation: Animation?
        
        var body: some View {
            ZStack {
                EmptyView()
                
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

public extension View {
    func present<Content: View>(isPresented: Binding<Bool>, with animation: Animation? = .default, @ViewBuilder content: @escaping () -> Content) -> some View {
        modifier(_ModalPresentViewModifer(isPresented: isPresented, with: animation, sheet: content))
    }
}
