//
//  IOS6RootView.swift
//  IOS6
//
//  Created by Xuan Li on 7/4/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

/// A root View for injecting systems and screen behaviors.
///
/// Root view enables lots of  system and screen behaviors in `IOS6SwfitUI`,
/// such as `ios6StatusBar`and `ios6RootBackground`. Therefore
/// this view is recommanded to be used at the top of view hierarchy.
public struct IOS6RootView<Content: View>: View {
    private let rootView: () -> Content
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
            .buttonStyle(IOS6DefaultButtonStyle())
            
            GeometryReader { proxy in
                self.StatusBar
                    .clipShape(_PaddingRectangle(bottom: proxy.safeAreaInsets.bottom + proxy.size.height))
                    .allowsHitTesting(false)
                    .edgesIgnoringSafeArea(.all)
            }
        }
    }
    
    /// An initializer with root view
    /// - Parameter rootView: root View
    public init(@ViewBuilder rootView: @escaping () -> Content) {
        self.rootView = rootView
    }
    
    private var StatusBar: AnyView {
        statusBar == nil ? AnyView(EmptyView()) : statusBar!.label
    }
    
    private var Background: AnyView {
        rootBackground == nil ? AnyView(Color.black.edgesIgnoringSafeArea(.all)) : rootBackground!.label
    }
}

struct IOS6RootView_Previews: PreviewProvider {
    static var previews: some View {
        IOS6RootView {
            Text("Test")
        }
    }
}

/// `Private API`:
/// A rectangle shape with padding
struct _PaddingRectangle: Shape, InsettableShape {
    
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
