//
//  DismissView.swift
//  IOS6
//
//  Created by Xuan Li on 5/15/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI
import IOS6SwiftUI

struct DismissView: View {
    @Environment(\.ios6PresentationMode) var presentMode
    @Binding var allowDismiss: Bool
    let avaliable: Bool
    
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            
            VStack {
                if avaliable {
                    IOS6Toggle(isOn: $allowDismiss) {
                        Text("Allow Adaptive Dismiss").foregroundColor(.black)
                    }.padding()
                }
                
                Button(action: {
                    self.presentMode.dismiss()
                }) {
                    Text(self.presentMode.isPresented ? "Can dismiss" : "no dismiss")
                        .fontWeight(.semibold)
                        .ios6ForegroundColor(.black)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.5), lineWidth: 1))
                }
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                .buttonStyle(DefaultButtonStyle())
            }
        }
    }
    
    init(allowDismiss: Binding<Bool>? = nil) {
        if let dismiss = allowDismiss {
            _allowDismiss = dismiss
            avaliable = true
        } else {
            _allowDismiss = .constant(true)
            avaliable = false
        }
        
        
    }
}

struct FullScreenView_Previews: PreviewProvider {
    static var previews: some View {
        DismissView()
    }
}
