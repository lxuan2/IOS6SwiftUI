//
//  IOS6NavigationPageView.swift
//  IOS6
//
//  Created by Xuan Li on 4/25/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct IOS6NavigationPageView: UIViewControllerRepresentable {
    
    let content: UIViewController
    
    init<Page: View>(page: Page) {
        content = UIHostingController(rootView: page)
        content.modalPresentationStyle = .overCurrentContext
        content.view.backgroundColor = UIColor.clear
        content.view.isOpaque = false
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        return content
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
}

struct IOS6NavigationPageView_Previews: PreviewProvider {
    static var previews: some View {
        IOS6NavigationPageView(page: Text("Test"))
    }
}
