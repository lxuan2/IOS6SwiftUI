//
//  IOS6NavigationContentView.swift
//  IOS6
//
//  Created by Xuan Li on 5/5/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct IOS6NavigationContentView: View {
    let navigationBarHeight: CGFloat = 45
    let interactiveSwipe: Bool
    @EnvironmentObject var viewStack: IOS6NavigationStack
    
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .leading) {
                ZStack {
                    ForEach(0 ..< self.viewStack.count, id: \.self) { index in
                        self.viewStack[index]
                            .transition(.move(edge: .trailing))
                            .offset(x: index < self.viewStack.count - 2 ? -proxy.size.width :
                                index == self.viewStack.count - 2 ? -proxy.size.width + self.viewStack.dragAmount :
                                self.viewStack.dragAmount,
                                    y: 0)
                            .onPreferenceChange(IOS6NavigationBarTitleKey.self) { title in
                                self.viewStack.updateTitle(at: index, with: title)
                        }
                    }
                }
                .compositingGroup()
                .gesture(TapGesture(), including: self.viewStack.blocking ? .none: .subviews)
                
                if self.interactiveSwipe {
                    Color.clear
                        .frame(width: self.viewStack.blocking ? 0 : 20)
                        .contentShape(Rectangle())
                        .gesture(
                            DragGesture()
                                .onChanged { self.viewStack.updateOffset(with: $0) }
                                .onEnded { self.viewStack.endOffset(with: $0, in: proxy) }
                    )
                }
            }
        }
    }
}

struct IOS6NavigationContentView_Previews: PreviewProvider {
    static var previews: some View {
        IOS6NavigationContentView(interactiveSwipe: true)
    }
}
