//
//  ModelLink.swift
//  IOS6
//
//  Created by Xuan Li on 5/13/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

public struct ModelLink<Label: View, Destination : View>: View {
    let label: Label
    let destination: Destination
    let sectionPostion: IOS6SectionItemPosition
    @State private var sheet = false
    @Environment(\.viewController) var viewController
    
    public var body: some View {
        Button(action: {
//            self.viewController?.present(with: .easeOut(duration: 0.4)) {
//                self.destination
//            }
        }) {
            HStack(spacing: 0){
                label
                Spacer()
            }
        }.buttonStyle(IOS6ButtonStyle(at: sectionPostion))
    }
    
    public init(@ViewBuilder destination: () -> Destination, @ViewBuilder label: () -> Label, sectionPostion: IOS6SectionItemPosition = .medium) {
        self.destination = destination()
        self.label = label()
        self.sectionPostion = sectionPostion
    }
}

struct ModelLink_Previews: PreviewProvider {
    static var previews: some View {
        ModelLink(destination: {Text("Destination")}, label: {Text("Model Link")})
    }
}
