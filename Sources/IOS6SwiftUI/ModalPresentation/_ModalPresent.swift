//
//  _ModalPresent.swift
//  IOS6
//
//  Created by Xuan Li on 5/13/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct _ModalPresent<NewContent: View>: ViewModifier {
    @Environment(\._viewController) private var viewController
    @Binding private var isPresented: Bool
    @State private var vc: Bool = false
    
    private let sheet: NewContent
    private let animation: Animation?
    
    init(isPresented : Binding<Bool>, with animation: Animation? = .default, sheet: NewContent) {
        self._isPresented = isPresented
        self.sheet = sheet
        self.animation = animation
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
                    controller.present {
                        _PresentationView(show: self.$isPresented, content: self.sheet, animation: self.animation)
                    }
                    self.vc = true
                } else if !show, self.isShown {
                    self.vc = false
                }
        }
    }
    
    private var isShown: Bool {
        vc
    }
    
    struct _PresentationView<Content: View>: View {
        @State private var localShow: Bool = false
        @Binding var show: Bool
        @Environment(\._viewController) private var viewController
        
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
                        if let ctl = self.viewController {
                            _ModalPresentUIKit<Spacer>.removeChild(viewController: ctl)
                        }
                        withAnimation(self.animation) {
                            self.localShow = false
                        }
                    }
                }
                
                if localShow {
                    Spacer()
                        .onDisappear {
                            self.viewController?.dismiss(animated: false, completion: nil)
                    }
                    content
                }
            }.environment(\.ios6PresentationMode, IOS6PresentationMode(show: self.$show))
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
        modifier(_ModalPresent(isPresented: isPresented, with: animation, sheet: content()))
    }
}
