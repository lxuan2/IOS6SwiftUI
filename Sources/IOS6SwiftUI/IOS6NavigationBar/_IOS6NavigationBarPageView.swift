//
//  _IOS6NavigationBarPageView.swift
//  IOS6
//
//  Created by Xuan Li on 4/25/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

/// `Private API`:
struct _IOS6NavigationBarPageView: View {
    var title: String?
    var backTitle: String?
    var index: Int
    var dismiss: () -> Void
    let space: CGFloat = 5.5
    
    var body: some View {
        HStack(spacing: self.space) {
            if self.isBackButtonShown {
                Button(self.backTitle ?? "Back") {
                    self.dismiss()
                }
                .buttonStyle(_IOS6NavigationBackButtonStyle())
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            } else {
                Spacer()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            
            _IOS6NavigationBarTitleView(title: self.title)
                .fixedSize()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            Spacer()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .lineLimit(1)
        .padding(.horizontal, self.space)
    }
    
    var isBackButtonShown: Bool {
        self.index > 0
    }
}

struct IOS6NavigationBarPageView_Previews: PreviewProvider {
    static var previews: some View {
        _IOS6NavigationBarPageView(title: "Title", backTitle: "Previous", index: 1, dismiss: {})
    }
}
