//
//  _IOS6FormCellConfig.swift
//  IOS6SwiftUI
//
//  Created by Xuan Li on 4/17/20.
//

import SwiftUI

/// `Private API`:
/// A ViewModifer configuring Form / List cell to match etched style in IOS6.
struct _IOS6FormCellConfig<Wallpaper: View>: ViewModifier {
    private let pos: IOS6FormCellSectionPosition
    private let background: Wallpaper
    private let isLink: Bool
    
    init(at postion: IOS6FormCellSectionPosition, background: Wallpaper) {
        pos = postion
        self.background = background
        isLink = false
    }
    
    init(at postion: IOS6FormCellSectionPosition, background: Wallpaper, isLink: Bool) {
        pos = postion
        self.background = background
        self.isLink = isLink
    }
    
    func body(content: Content) -> some View {
        content
            .listRowInsets(pos == .none ? nil : EdgeInsets(top: 9.5, leading: 10, bottom: 9.5, trailing: isLink ? 31.5 : 10))
            .listRowBackground( pos == .none ? nil : _BackgroundView(pos: pos, background: background))
    }
    
    struct _BackgroundView<_Background: View>: View {
        let pos: IOS6FormCellSectionPosition
        let background: _Background
        
        var body: some View {
            ZStack {
                if pos == .bottom {
                    _DownRectangle(cornerRadius: 10, padding: 0.8)
                        .strokeBorder(Color(red: 180.0/255.0, green: 180.0/255.0, blue: 180.0/255.0), lineWidth: 1)
                }
                
                background
                
                VStack(spacing: 0) {
                    if pos == .medium || pos == .bottom || pos == .list {
                        Color.white
                            .blendMode(.destinationOver)
                            .frame(minHeight: 1, maxHeight: 1)
                    }
                    
                    Spacer()
                    
                    if pos == .medium || pos == .top || pos == .list {
                        Color.black.opacity(0.18)
                            .frame(minHeight: 1, maxHeight: 1)
                    }
                }
                
                if pos == .top {
                    _UpCap(cornerRadius: 11).stroke(Color.black.opacity(0.225), lineWidth: 1).blur(radius: 0.6)
                    _UpRectangle(cornerRadius: 10).strokeBorder(Color(red: 180.0/255.0, green: 180.0/255.0, blue: 180.0/255.0), lineWidth: 1)
                }
                
                if pos == .medium {
                    HStack {
                        Color(red: 180.0/255.0, green: 180.0/255.0, blue: 180.0/255.0)
                            .frame(minWidth: 1, maxWidth: 1)
                        
                        Spacer()
                        
                        Color(red: 180.0/255.0, green: 180.0/255.0, blue: 180.0/255.0)
                            .frame(minWidth: 1, maxWidth: 1)
                    }
                }
                
                if pos == .single {
                    RoundedRectangle(cornerRadius: 10).strokeBorder(Color(red: 180.0/255.0, green: 180.0/255.0, blue: 180.0/255.0), lineWidth: 1)
                }
            }
        }
    }
}

/// The shape of RoundRectangle but only top cap
struct _UpCap: Shape, InsettableShape {
    
    private let cornerRadius: CGFloat
    private var insetAmount: CGFloat = 0
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: insetAmount, y: cornerRadius + insetAmount + 1))
        path.addArc(center: CGPoint(x: cornerRadius + insetAmount, y: cornerRadius + insetAmount + 1),
                    radius: cornerRadius,
                    startAngle: Angle(degrees: 180.0),
                    endAngle: Angle(degrees: 270.0),
                    clockwise: false,
                    transform: CGAffineTransform(scaleX: 1.00, y: 1.00))
        path.addLine(to: CGPoint(x: rect.width - cornerRadius - insetAmount, y: insetAmount + 1))
        path.addArc(center: CGPoint(x: rect.width - cornerRadius - insetAmount, y: cornerRadius + insetAmount + 1),
                    radius: cornerRadius,
                    startAngle: Angle(degrees: 270.0),
                    endAngle: Angle(degrees: 0.00),
                    clockwise: false,
                    transform: CGAffineTransform(scaleX: 1.00, y: 1.00))
        
        return path
    }
    
    init(cornerRadius: CGFloat) {
        self.cornerRadius = cornerRadius
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
}

/// The shape of RoundRectangle but only top part
struct _UpRectangle: Shape, InsettableShape {
    
    private let cornerRadius: CGFloat
    private var insetAmount: CGFloat = 0
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: insetAmount, y: rect.height))
        path.addLine(to: CGPoint(x: insetAmount, y: cornerRadius + insetAmount))
        path.addArc(center: CGPoint(x: cornerRadius + insetAmount, y: cornerRadius + insetAmount),
                    radius: cornerRadius,
                    startAngle: Angle(degrees: 180.0),
                    endAngle: Angle(degrees: 270.0),
                    clockwise: false,
                    transform: CGAffineTransform(scaleX: 1.00, y: 1.00))
        path.addLine(to: CGPoint(x: rect.width - cornerRadius - insetAmount, y: insetAmount))
        path.addArc(center: CGPoint(x: rect.width - cornerRadius - insetAmount, y: cornerRadius + insetAmount),
                    radius: cornerRadius,
                    startAngle: Angle(degrees: 270.0),
                    endAngle: Angle(degrees: 0.00),
                    clockwise: false,
                    transform: CGAffineTransform(scaleX: 1.00, y: 1.00))
        path.addLine(to: CGPoint(x: rect.width - insetAmount, y: rect.height))
        
        return path
    }
    
    init(cornerRadius: CGFloat) {
        self.cornerRadius = cornerRadius
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
}

/// The shape of RoundRectangle but only bottom part
struct _DownRectangle: Shape, InsettableShape {
    
    private let cornerRadius: CGFloat
    private let padding: CGFloat
    private var insetAmount: CGFloat = 0
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: insetAmount, y: 0))
        path.addLine(to: CGPoint(x: insetAmount, y: rect.height - cornerRadius - insetAmount - padding))
        path.addArc(center: CGPoint(x: cornerRadius + insetAmount, y: rect.height - cornerRadius - insetAmount - padding),
                    radius: cornerRadius,
                    startAngle: Angle(degrees: 180.0),
                    endAngle: Angle(degrees: 90.0),
                    clockwise: true,
                    transform: CGAffineTransform(scaleX: 1.00, y: 1.00))
        path.addLine(to: CGPoint(x: rect.width - cornerRadius - insetAmount, y: rect.height - insetAmount - padding))
        path.addArc(center: CGPoint(x: rect.width - cornerRadius - insetAmount, y: rect.height - cornerRadius - insetAmount - padding),
                    radius: cornerRadius,
                    startAngle: Angle(degrees: 90.0),
                    endAngle: Angle(degrees: 360.00),
                    clockwise: true,
                    transform: CGAffineTransform(scaleX: 1.00, y: 1.00))
        path.addLine(to: CGPoint(x: rect.width - insetAmount, y: 0))
        
        return path
    }
    
    init(cornerRadius: CGFloat, padding: CGFloat) {
        self.cornerRadius = cornerRadius
        self.padding = padding
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
}
