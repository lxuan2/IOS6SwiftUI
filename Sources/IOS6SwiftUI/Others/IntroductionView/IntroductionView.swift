//
//  IntroductionView.swift
//  animation
//
//  Created by Xuan Li on 1/16/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct IntroductionView<Content: View>: View {
    @Environment(\.presentationMode) var presentationMode
    
    var title: String
    var subTitle: String
    var image: Image?
    var imageName: String
    var accentColor: Color
    let content: () -> Content
    
    var body: some View {
        VStack(alignment: .center) {
            
            Spacer().frame(height: 35).fixedSize()
            
            if imageName.isEmpty {
                TitleView(title: title, subTitle: subTitle, image: image!, accentColor: accentColor)
            } else {
                TitleView(title: title, subTitle: subTitle, imageName: imageName, accentColor: accentColor)
            }

            InformationContainerView {
                self.content()
            }

            Spacer(minLength: 30)

            Button(action: {
//                    let generator = UINotificationFeedbackGenerator()
//                    generator.notificationOccurred(.success)
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Text("Continue")
            }.buttonStyle(AppleBlueButtonStyle(color: accentColor))
            
            Spacer().frame(height: 35).fixedSize()
        }
            .padding()
    }
    
    init(title: String, subTitle: String, imageName: String, accentColor: Color = .blue, @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.title = title
        self.subTitle = subTitle
        self.image = nil
        self.imageName = imageName
        self.accentColor = accentColor
    }
    
    init(title: String, subTitle: String, image: Image, accentColor: Color = .blue, @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.title = title
        self.subTitle = subTitle
        self.image = image
        self.imageName = ""
        self.accentColor = accentColor
    }
}

struct IntroductionView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            IntroductionView(title: "Welcome to", subTitle: "Hammer Game", imageName: "hammer", accentColor: .orange) {
                InformationDetailView(title: "Match", subTitle: "Match the gradients by moving the Red, Green and Blue sliders for the left and right colors.", imageName:  "slider.horizontal.below.rectangle", accentColor: .orange)

                InformationDetailView(title: "Precise", subTitle: "More precision with the steppers to get that 100 score.", imageName:  "minus.slash.plus", accentColor: .orange)

                InformationDetailView(title: "Score", subTitle: "A detailed score and comparsion of your gradient and the target gradient.",imageName: "checkmark.square", accentColor: .orange)
            }
            
            IntroductionView(title: "Welcome to", subTitle: "Hammer Game", image: Image("ins"), accentColor: .orange) {
                InformationDetailView(title: "Match", subTitle: "Match the gradients by moving the Red, Green and Blue sliders for the left and right colors.", imageName:  "slider.horizontal.below.rectangle", accentColor: .orange)

                InformationDetailView(title: "Precise", subTitle: "More precision with the steppers to get that 100 score.", imageName:  "minus.slash.plus", accentColor: .orange)

                InformationDetailView(title: "Score", subTitle: "A detailed score and comparsion of your gradient and the target gradient.",imageName: "checkmark.square", accentColor: .orange)
            }
        }
    }
}
