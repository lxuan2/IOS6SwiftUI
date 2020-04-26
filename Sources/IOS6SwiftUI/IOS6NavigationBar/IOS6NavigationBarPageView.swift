//
//  IOS6NavigationBarPageView.swift
//  IOS6
//
//  Created by Xuan Li on 4/25/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct IOS6NavigationBarPageView: View {
    let title: String?
    let backTitle: String?
    
    @EnvironmentObject private var stack: IOS6NavigationStack
    
    var body: some View {
        ZStack {
            if stack.count > 1 {
                Button(backTitle ?? "Back") {
                    self.stack.pop()
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
        IOS6NavigationBarPageView(title: "Title", backTitle: "Previous")
    }
}
