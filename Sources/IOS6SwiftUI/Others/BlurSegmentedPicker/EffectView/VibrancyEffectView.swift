//
//  VibrancyEffectView.swift
//  test
//
//  Created by Xuan Li on 8/2/20.
//

import SwiftUI

struct VibrancyEffectView<Content: View>: UIViewRepresentable {
    let content: Content
    let blurEffect: UIBlurEffect.Style
    let style: UIVibrancyEffectStyle?
    
    init(blurEffect: UIBlurEffect.Style, style: UIVibrancyEffectStyle? = nil, content: Content) {
        self.content = content
        self.blurEffect = blurEffect
        self.style = style
    }
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        let hostingController = UIHostingController(rootView: content)
        hostingController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        hostingController.view.backgroundColor = nil
        
        let visualEffectView = UIVisualEffectView()
        visualEffectView.contentView.addSubview(hostingController.view)
        
        return visualEffectView
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        let blur = UIBlurEffect(style: blurEffect)
        UIView.animate(withDuration: 0.3) {
            if let vibrancy = self.style {
                uiView.effect = UIVibrancyEffect(blurEffect: blur, style: vibrancy)
            } else {
                uiView.effect = UIVibrancyEffect(blurEffect: blur)
            }
        }
    }
}

public extension View {
    func vibrancyEffect(blurEffect: UIBlurEffect.Style = .systemMaterial, style: UIVibrancyEffectStyle? = nil) -> some View {
        self
            .hidden()
            .overlay(VibrancyEffectView(blurEffect: blurEffect, style: style, content: self))
    }
}

struct VibrancyEffectView_Previews: PreviewProvider {
    static var previews: some View {
        Image(systemName: "star.fill")
            .resizable()
            .frame(width: 50, height: 50, alignment: .center)
            .vibrancyEffect()
    }
}
