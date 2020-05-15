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
    
    let sheet: () -> NewContent
    let animation: Animation?
    
    init(isPresented : Binding<Bool>, with animation: Animation? = .default, sheet: @escaping () -> NewContent) {
        self._isPresented = isPresented
        self.sheet = sheet
        self.animation = animation
    }
    
    func body(content: Content) -> some View {
        if isPresented, viewController?.presentedViewController == nil{
            self.viewController?.present {
                ModelView(show: self.$isPresented, content: self.sheet, animation: self.animation)
            }
        }
        return content.onAppear(perform: {if self.isPresented {}})
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
