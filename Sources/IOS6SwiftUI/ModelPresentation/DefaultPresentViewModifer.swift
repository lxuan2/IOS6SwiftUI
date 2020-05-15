//
//  DefaultPresentViewModifer.swift
//  IOS6
//
//  Created by Xuan Li on 5/14/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct DefaultPresentViewModifer<NewContent: View>: ViewModifier {
    @Environment(\.viewController) private var viewController
    @Binding var isPresented: Bool
    
    let sheet: () -> NewContent
    let style: UIModalPresentationStyle
    
    init(isPresented : Binding<Bool>, with style: UIModalPresentationStyle, sheet: @escaping () -> NewContent) {
        self._isPresented = isPresented
        self.sheet = sheet
        self.style = style
    }
    
    func body(content: Content) -> some View {
        if isPresented, viewController?.presentedViewController == nil{
            viewController?.present(style: style) {
                self.sheet()
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
        return content.onAppear(perform: {if self.isPresented {}})
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
