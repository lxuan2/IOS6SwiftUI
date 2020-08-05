//
//  AppleBlueButtonStyle.swift
//  animation
//
//  Created by Xuan Li on 1/19/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct AppleBlueButtonStyle: ButtonStyle {
    var color: Color = .blue
    
    public func makeBody(configuration: AppleBlueButtonStyle.Configuration) -> some View {
        AppleBlueButton(configuration: configuration, color: color)
    }
    
    struct AppleBlueButton: View {
        let configuration: AppleBlueButtonStyle.Configuration
        let color: Color
        
        var body: some View {
            
            return configuration.label
                .foregroundColor(.white)
                .font(.headline)
                .padding()
                .frame(maxWidth: 350, alignment: .center)
                .background(RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .fill(color))
                .opacity(configuration.isPressed ? 0.5 : 1.0)
        }
    }

}

struct AppleBlueButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Button("Tap Me!") {
            print("button pressed!")
        }.buttonStyle(AppleBlueButtonStyle(color: .blue))
    }
}
