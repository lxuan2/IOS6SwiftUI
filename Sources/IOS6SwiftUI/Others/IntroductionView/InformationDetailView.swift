//
//  InformationDetailView.swift
//  animation
//
//  Created by Xuan Li on 1/16/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct InformationDetailView: View {
    var title: String
    var subTitle: String
    var image: AnyView

    var body: some View {
        HStack(alignment: .center) {
            image
                .frame(width: 40)
                .padding([.trailing, .vertical])
                .accessibility(hidden: true)

            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .accessibility(addTraits: .isHeader)

                Text(subTitle)
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
            .padding(.top)
    }
    
    init(title: String, subTitle: String, image: Image) {
        self.title = title
        self.subTitle = subTitle
        self.image = AnyView(image
            .resizable()
            .aspectRatio(contentMode: .fit)
            .cornerRadius(4))
            
    }
    
    init(title: String, subTitle: String, imageName: String, accentColor: Color = .blue) {
        self.title = title
        self.subTitle = subTitle
        self.image = AnyView(
            Image(systemName: imageName)
                .foregroundColor(accentColor)
                .font(.largeTitle))
                
    }
}

struct InformationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            InformationDetailView(title: "Title", subTitle: "SubTitle", imageName: "photo", accentColor: .blue)
            InformationDetailView(title: "Title", subTitle: "SubTitle", image: Image("ins"))
        }
    }
}
