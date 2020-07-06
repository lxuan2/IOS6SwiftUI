//
//  _IOS6NavigationPageView.swift
//  IOS6
//
//  Created by Xuan Li on 4/25/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

/// `Private API`:
struct _IOS6NavigationPageView: UIViewControllerRepresentable, Identifiable {
    private let content: UIViewController
    let lock: Binding<Bool>?
    let id: Int
    
    init<Page: View>(page: Page, index: Int, previousPageLock: Binding<Bool>? = nil) {
        content = UIHostingController(rootView: page)
        lock = previousPageLock
        id = index
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        content.view.backgroundColor = UIColor.clear
        content.view.isOpaque = false
        return content
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

struct IOS6NavigationPageView_Previews: PreviewProvider {
    static var previews: some View {
        _IOS6NavigationPageView(page: Text("Test"), index: 0)
    }
}
