//
//  IOS6Badge.swift
//  IOS6
//
//  Created by Xuan Li on 7/7/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

public struct IOS6Badge<Label: View>: View {
    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.ios6ButtonSelected) private var isSelected
    let regularColor: Color
    let activeColor: Color
    let label: Label
    let radius: CGFloat = 23
    let isEtched: Bool
    let paddingRatio: CGFloat
    
    public var body: some View {
        Circle()
            .fill(isSelected ? activeColor : regularColor)
            .shadow(color: Color.black.opacity(0.8), radius: boudaryWidth/1.5, x: 0, y: 0)
            .shadow(color: Color.black.opacity(0.3), radius: boudaryWidth/1.5, x: 0, y: boudaryWidth * 1.1)
            .overlay(whiteCircleShadow)
            .overlay(whiteCircle)
            .overlay(_CuttingCircle().fill(coverGradient))
            .overlay(labelView)
            .frame(width: radius, height: radius)
    }
    
    var whiteCircleShadow: some View {
        Circle()
            .strokeBorder(Color.black.opacity(0.4), lineWidth: 1)
            .padding(boudaryWidth / 3)
            .blur(radius: boudaryWidth / 3)
    }
    
    var whiteCircle: some View {
        Circle().stroke(Color.white, lineWidth: boudaryWidth)
    }
    
    var boudaryWidth:CGFloat {
        radius * 0.1
    }
    
    var coverGradient: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [
            Color.white.opacity(0.6),
            Color.white.opacity(0.15),
            Color.white.opacity(0.15)]), startPoint: .top, endPoint: .bottom)
    }
    
    var labelView: some View {
        label
            .shadow(color: Color.black.opacity(isEnabled && isEtched ? 0.27 : 0), radius: 0, x: 0, y: -boudaryWidth/2.5)
            .padding(boudaryWidth * paddingRatio)
            .foregroundColor(.white)
            .colorMultiply(.white)
    }
    
    struct _CuttingCircle: Shape {
        let dampRatio: CGFloat = 0.725
        let angleReduce: Double = 150
        func path(in rect: CGRect) -> Path {
            let radius = min(rect.midX, rect.midY)
            var path = Path()
            
            path.addArc(center: CGPoint(x: rect.midX, y: rect.midY),
                        radius: radius,
                        startAngle: Angle(degrees: 90 + angleReduce/2),
                        endAngle: Angle(degrees: 90 - angleReduce/2),
                        clockwise: false)
            
            path.addQuadCurve(to: CGPoint(x: rect.width-path.currentPoint!.x, y: path.currentPoint!.y), control: CGPoint(x: rect.width / 2, y: path.currentPoint!.y - radius * dampRatio))
            
            return path
        }
    }
    
    public init(regularColor: Color?=nil, activeColor: Color?=nil, isEtched: Bool = true, paddingRatio: CGFloat = 1, label: () -> Label) {
        self.regularColor = regularColor ?? Color(red: 34/255.0, green: 113/255.0, blue: 218/255.0)
        self.activeColor = activeColor ?? Color(red: 18/255.0, green: 63/255.0, blue: 128/255.0)
        self.label = label()
        self.isEtched = isEtched
        self.paddingRatio = paddingRatio
    }
}

struct IOS6SignIcon_Previews: PreviewProvider {
    static var previews: some View {
        IOS6Badge {
            Image(systemName: "chevron.right")
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }
}
