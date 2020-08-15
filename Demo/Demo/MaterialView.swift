//
//  MaterialView.swift
//  test
//
//  Created by Xuan Li on 8/2/20.
//

import SwiftUI
import IOS6SwiftUI

struct MaterialView: View {
    @State private var selection: UIBlurEffect.Style = .systemThinMaterial
    @State private var offset: CGPoint = .init(x: 0, y: 0)
    @State private var selection1: UIVibrancyEffectStyle = .fill
    
    var body: some View {
        VStack {
            ZStack {
                Image("ins").resizable()
                ZStack {
                    BlurEffect(blurStyle: selection)
                        .frame(width: 100, height: 100, alignment: .center)
                        .offset(x: offset.x, y: offset.y)
                    
                    VibrancyEffect(blurStyle: selection, vibrancyStyle: selection1) {
                        Image(systemName: "star.fill")
                            .resizable()
                    }
                    .frame(width: 50, height: 50, alignment: .center)
                }
                .simultaneousGesture(
                    DragGesture()
                        .onChanged { value in
                            self.offset = .init(x: value.translation.width, y: value.translation.height)
                    }
                    .onEnded { _ in
                        withAnimation {
                            self.offset = .init(x: 0, y: 0)
                        }
                    }
                )
            }
            ScrollView(.vertical) {
                VStack(spacing: 0) {
                    Picker(selection: self.$selection, label: Text("Background")) {
                        HStack {
                            Image(systemName: "person.fill")
                            Text("tick")
                        }.tag(UIBlurEffect.Style.systemThickMaterial)
                        
                        HStack {
                            Image(systemName: "person.2.fill")
                            Text("regular")
                        }.tag(UIBlurEffect.Style.systemMaterial)
                        
                        HStack {
                            Image(systemName: "person.3.fill")
                            Text("thin")
                        }.tag(UIBlurEffect.Style.systemThinMaterial)
                        
                        HStack {
                            Image(systemName: "person.3.fill")
                            Text("ultra thin")
                        }.tag(UIBlurEffect.Style.systemUltraThinMaterial)
                    }
                    
                    Picker(selection: self.$selection1, label: Text("Foreground")) {
                        HStack {
                            Image(systemName: "person.fill")
                            Text("fill")
                        }.tag(UIVibrancyEffectStyle.fill)
                        
                        HStack {
                            Image(systemName: "person.2.fill")
                            Text("label")
                        }.tag(UIVibrancyEffectStyle.label)
                        
                        HStack {
                            Image(systemName: "person.3.fill")
                            Text("quaternaryLabel")
                        }.tag(UIVibrancyEffectStyle.quaternaryLabel)
                        
                        HStack {
                            Image(systemName: "person.3.fill")
                            Text("secondaryFill")
                        }.tag(UIVibrancyEffectStyle.secondaryFill)
                        
                        HStack {
                            Image(systemName: "person.3.fill")
                            Text("secondaryLabel")
                        }.tag(UIVibrancyEffectStyle.secondaryLabel)
                        
                        HStack {
                            Image(systemName: "person.3.fill")
                            Text("separator")
                        }.tag(UIVibrancyEffectStyle.separator)
                        
                        HStack {
                            Image(systemName: "person.3.fill")
                            Text("tertiaryFill")
                        }.tag(UIVibrancyEffectStyle.tertiaryFill)
                        
                        HStack {
                            Image(systemName: "person.3.fill")
                            Text("tertiaryLabel")
                        }.tag(UIVibrancyEffectStyle.tertiaryLabel)
                    }
                }
            }
        }
    }
}

struct MaterialView_Previews: PreviewProvider {
    static var previews: some View {
        MaterialView()
    }
}
