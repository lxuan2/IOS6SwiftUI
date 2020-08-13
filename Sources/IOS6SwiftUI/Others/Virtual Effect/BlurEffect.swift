//
//  BlurEffect.swift
//  IOS6
//
//  Created by Xuan Li on 8/12/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

// MARK: - BlurEffect

public struct BlurEffect: View {
    var blurStyle: UIBlurEffect.Style

    public init(blurStyle: UIBlurEffect.Style = .systemMaterial) {
        self.blurStyle = blurStyle
    }

    public var body: some View {
        Representable(blurStyle: blurStyle)
    }
}

// MARK: - Representable

extension BlurEffect {
    struct Representable: UIViewRepresentable {
        var blurStyle: UIBlurEffect.Style

        func makeUIView(context: Context) -> UIVisualEffectView {
            let blurView = UIVisualEffectView()
            blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            return blurView
        }

        func updateUIView(_ view: UIVisualEffectView, context: Context) {
            let blurEffect = UIBlurEffect(style: blurStyle)
            view.effect = blurEffect
        }
    }
}

// MARK: - Previews

struct BlurEffect_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.red, .blue]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            BlurEffect(blurStyle: .systemUltraThinMaterial)
        }
        .previewLayout(.sizeThatFits)
    }
}

