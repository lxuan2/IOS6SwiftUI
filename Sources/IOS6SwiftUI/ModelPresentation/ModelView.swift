//
//  ModelView.swift
//  IOS6
//
//  Created by Xuan Li on 5/14/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct ModelView<Content: View>: View {
    @State private var localShow: Bool = false
    @Environment(\.viewController) private var viewController
    
    @Binding var show: Bool
    let content: () -> Content
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
                content()
                    .environment(\.presentMode, PresentMode(show: $show))
                    .onDisappear {
                        self.viewController?.dismiss(animated: false, completion: nil)
                }
            }
        }
    }
}


struct ModelView_Previews: PreviewProvider {
    static var previews: some View {
        ModelView(show: .constant(true), content: {Text("Test")}, animation: .default)
    }
}
