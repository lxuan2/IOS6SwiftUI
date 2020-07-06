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
        GeometryReader { proxy in
            ZStack {
                if self.isBackButtonShown {
                    HStack(spacing: 0) {
                        Button(self.backTitle ?? "Back") {
                            self.dismiss()
                        }
                        .buttonStyle(_IOS6NavigationBackButtonStyle())
                        .padding(.horizontal, self.space)
                        Spacer(minLength: proxy.size.width / 4 * 3)
                    }
                    .zIndex(0)
                }
                
                _IOS6NavigationBarTitleView(title: self.title)
                    .padding(.horizontal, proxy.size.width / 4.5)
                    .truncationMode(.middle)
                    .zIndex(1)
            }
            .lineLimit(1)
        }
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
