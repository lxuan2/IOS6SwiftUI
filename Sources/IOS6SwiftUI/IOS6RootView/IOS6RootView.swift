//
//  IOS6RootView.swift
//  IOS6
//
//  Created by Xuan Li on 7/4/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

public struct IOS6RootView<Content: View>: View {
    let rootView: () -> Content
    @State private var rootBackground: _IOS6RootBackgroundData? = nil
    @State private var statusBar: _IOS6StatusBarData? = nil
    
    public var body: some View {
        ZStack {
            Background
            
            rootView()
                .onPreferenceChange(_IOS6RootBackgroundKey.self) { builder in
                    self.rootBackground = builder
            }
            .onPreferenceChange(_IOS6StatusBarKey.self) { builder in
                self.statusBar = builder
            }
            
            GeometryReader { proxy in
                self.StatusBar
                    .clipShape(PaddingRectangle(bottom: proxy.safeAreaInsets.bottom + proxy.size.height))
                    .allowsHitTesting(false)
                    .edgesIgnoringSafeArea(.all)
            }
        }
    }
    
    public init(@ViewBuilder rootView: @escaping () -> Content) {
        self.rootView = rootView
    }
    
    var StatusBar: AnyView {
        statusBar == nil ? AnyView(EmptyView()) : statusBar!.label()
    }
    
    var Background: AnyView {
        rootBackground == nil ? AnyView(Color.black.edgesIgnoringSafeArea(.all)) : rootBackground!.label()
    }
}

struct IOS6RootView_Previews: PreviewProvider {
    static var previews: some View {
        IOS6RootView {
            Text("Test")
        }
    }
}

struct PaddingRectangle: Shape, InsettableShape {
    
    private var insetAmount: CGFloat = 0
    let top: CGFloat
    let bottom: CGFloat
    let leading: CGFloat
    let trailing: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.addRect(.init(x: rect.minX + insetAmount + top,
                           y: rect.minY + insetAmount + leading,
                           width: rect.maxX - insetAmount - trailing,
                           height: rect.maxY - insetAmount - bottom))
        
        return path
    }
    
    init(top: CGFloat = 0, bottom: CGFloat = 0, leading: CGFloat = 0, trailing: CGFloat = 0) {
        self.top = top
        self.bottom = bottom
        self.leading = leading
        self.trailing = trailing
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
}
