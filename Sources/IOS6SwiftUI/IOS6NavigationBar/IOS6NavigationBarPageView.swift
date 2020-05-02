//
//  IOS6NavigationBarPageView.swift
//  IOS6
//
//  Created by Xuan Li on 4/25/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct IOS6NavigationBarPageView: View {
    var title: String?
    var backTitle: String?
    var index: Int
    var dismiss: () -> Void
    
    var body: some View {
        ZStack {
            if index > 0 {
                Button(backTitle ?? "Back") {
                    self.dismiss()
                }
                .buttonStyle(IOS6NavigationBackButtonStyle())
                .padding(.leading, 5.5)
                .frame(maxWidth: .infinity, alignment: .leading)
                .zIndex(1)
            }
            
            IOS6NavigationBarTitle(title: title)
                .zIndex(0)
        }
        
    }
}

struct IOS6NavigationBarPageView_Previews: PreviewProvider {
    static var previews: some View {
        IOS6NavigationBarPageView(title: "Title", backTitle: "Previous", index: 1, dismiss: {})
    }
}
