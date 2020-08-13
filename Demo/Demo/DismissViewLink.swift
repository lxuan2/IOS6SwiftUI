//
//  DismissViewLink.swift
//  IOS6
//
//  Created by Xuan Li on 5/29/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI
import IOS6SwiftUI

struct DismissViewLink: View {
    @Environment(\.ios6PresentationMode) var presentMode
    var body: some View {
        IOS6NavigationLink(destination: DismissView().ios6NavigationBarTitle("Dismiss View")) {
            IOS6PresetTableCell(image: Image("AppleIDGameCenter").renderingMode(.original), title: "Dismiss View Link")
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color(red: 0.9, green: 0.9, blue: 0.9)))
                .compositingGroup()
                .shadow(radius: 5)
        }
        .ios6NavigationBarTitle("Dismiss View Link")
        .buttonStyle(DefaultButtonStyle())
    }
}

struct SingleLink_Previews: PreviewProvider {
    static var previews: some View {
        DismissViewLink()
    }
}
