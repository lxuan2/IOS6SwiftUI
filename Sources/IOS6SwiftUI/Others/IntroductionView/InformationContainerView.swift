//
//  InformationContainerView.swift
//  animation
//
//  Created by Xuan Li on 1/16/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct InformationContainerView<Content: View>: View {
    let content: () -> Content
    
    var body: some View {
        VStack(alignment: .leading) {
            self.content()
        }
        .frame(maxWidth: 440)
        .padding(.horizontal)
    }
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
}

struct InformationContainerView_Previews: PreviewProvider {
    static var previews: some View {
        InformationContainerView {
            InformationDetailView(title: "Match", subTitle: "Match the gradients by moving the Red, Green and Blue sliders for the left and right colors.", imageName:  "slider.horizontal.below.rectangle", accentColor: .blue)
            
            InformationDetailView(title: "Precise", subTitle: "More precision with the steppers to get that 100 score.", imageName:  "minus.slash.plus", accentColor: .blue)
            
            InformationDetailView(title: "Score", subTitle: "A detailed score and comparsion of your gradient and the target gradient.",imageName: "checkmark.square", accentColor: .blue)
        }
    }
}
