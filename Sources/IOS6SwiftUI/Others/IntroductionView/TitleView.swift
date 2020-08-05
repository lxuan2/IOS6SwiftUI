//
//  TitleView.swift
//  animation
//
//  Created by Xuan Li on 1/16/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct TitleView: View {
    var title: String
    var subTitle: String
    var image: AnyView
    var accentColor: Color
    
    var body: some View {
        VStack {
            image
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 58, maxHeight: 58, alignment: .center)
                .accessibility(hidden: true)
            
            Text(title)
                .fontWeight(.black)
                .font(.system(size: 36))
            
            Text(subTitle)
                .fontWeight(.black)
                .font(.system(size: 36))
                .foregroundColor(accentColor)
        }
    }
    
    init(title: String, subTitle: String, image: Image, accentColor: Color) {
        self.title = title
        self.subTitle = subTitle
        self.image = AnyView(image.resizable().cornerRadius(4))
        self.accentColor = accentColor
    }
    
    init(title: String, subTitle: String, imageName: String, accentColor: Color) {
        self.title = title
        self.subTitle = subTitle
        self.image = AnyView(
            Image(systemName: imageName)
                .foregroundColor(accentColor)
                .font(.system(size: 50))
        )
        self.accentColor = accentColor
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TitleView(title: "Welcome to", subTitle: "Hammer Game", imageName: "hammer", accentColor: .blue)
            TitleView(title: "Welcome to", subTitle: "Hammer Game", image: Image("ins"), accentColor: .blue)
        }
    }
}
