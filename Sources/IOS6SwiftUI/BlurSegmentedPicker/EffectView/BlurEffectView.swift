//
//  BlurEffectView.swift
//  test
//
//  Created by Xuan Li on 8/2/20.
//

import SwiftUI

public struct BlurEffectView: UIViewRepresentable {
    let style: UIBlurEffect.Style
    
    public init(style: UIBlurEffect.Style = .systemMaterial) {
        self.style = style
    }
    
    public func makeUIView(context: Context) -> UIVisualEffectView {
        UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    
    public func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        UIView.animate(withDuration: 0.3) {
            uiView.effect = UIBlurEffect(style: self.style)
        }
    }
}

struct BlurEffectView_Previews: PreviewProvider {
    static var previews: some View {
        BlurEffectView()
    }
}
