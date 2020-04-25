//
//  IOS6SectionItem.swift
//  IOS6SwiftUI
//
//  Created by Xuan Li on 4/17/20.
//

import SwiftUI

struct IOS6SectionItem: ViewModifier {
    let pos: IOS6SectionItemPosition
    
    init(at postion: IOS6SectionItemPosition) {
        pos = postion
    }
    
    func body(content: Content) -> some View {
        content
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            .listRowBackground(
                ZStack {
                    VStack(spacing: 0) {
                        if pos == .medium || pos == .bottom {
                            Color.white
                                .frame(minHeight: 1, maxHeight: 1)
                        }
                        
                        Spacer()
                        
                        if pos == .medium || pos == .top {
                            Color.black.opacity(0.18)
                                .frame(minHeight: 1, maxHeight: 1)
                        }
                    }
                    
                    if pos == .top {
                        UpCap(cornerRadius: 11).stroke(Color.black.opacity(0.25), lineWidth: 1).blur(radius: 0.6)
                        UpRectangle(cornerRadius: 10).strokeBorder(Color(red: 180.0/255.0, green: 180.0/255.0, blue: 180.0/255.0), lineWidth: 1)
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
                    
                    if pos == .bottom {
                        DownRectangle(cornerRadius: 10, padding: 1).strokeBorder(Color(red: 180.0/255.0, green: 180.0/255.0, blue: 180.0/255.0), lineWidth: 1)
                    }
                    
                    if pos == .all {
                        RoundedRectangle(cornerRadius: 10).strokeBorder(Color(red: 180.0/255.0, green: 180.0/255.0, blue: 180.0/255.0), lineWidth: 1)
                    }
                }
        )
        
    }
}

//struct IOS6SectionItem_Previews: PreviewProvider {
//    static var previews: some View {
//        IOS6SectionItem()
//    }
//}

struct UpCap: Shape, InsettableShape {
    
    let cornerRadius: CGFloat
    var insetAmount: CGFloat = 0
    
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
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
}


struct UpRectangle: Shape, InsettableShape {
    
    let cornerRadius: CGFloat
    var insetAmount: CGFloat = 0
    
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
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
}

struct DownRectangle: Shape, InsettableShape {
    
    let cornerRadius: CGFloat
    let padding: CGFloat
    var insetAmount: CGFloat = 0
    
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
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
}

struct IOS6SectionRectangle: Shape, InsettableShape {
    let direction: IOS6SectionItemPosition
    let cornerRadius: CGFloat
    let padding: CGFloat // Only for down
    var insetAmount: CGFloat = 0
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        if direction == .top {
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
        } else if direction == .medium {
            return Rectangle().path(in: rect)
        } else if direction == .bottom {
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
        } else {
            return RoundedRectangle(cornerRadius: cornerRadius).path(in: rect)
        }
        
        return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
}

public enum IOS6SectionItemPosition: Equatable {
    case top
    case medium
    case bottom
    case all
    
    public static func ==(lhs: IOS6SectionItemPosition, rhs: IOS6SectionItemPosition) -> Bool {
        switch (lhs, rhs) {
        case (.top, .top):
            return true
        case (.medium,.medium):
            return true
        case (.bottom,.bottom):
            return true
        case (.all,.all):
            return true
        default:
            return false
        }
    }
}

public extension View {
    func ios6SecItem(at postion: IOS6SectionItemPosition) -> some View {
        self.modifier(IOS6SectionItem(at: postion))
    }
}
