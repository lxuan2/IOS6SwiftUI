//
//  RoundWidget.swift
//  Demo
//
//  Created by Xuan Li on 8/30/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

public struct RoundWidget<Content: View>: View {
    @State private var percent: CGFloat = 0
    @State private var time: Date = Date()
    @Environment(\.ios6PresentationMode) private var presentMode
    let adaptiveDismissable: Bool
    let content: Content
    
    @ViewBuilder public var body: some View {
        Color.black.opacity(0.4)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
            .zIndex(0)
        
        GeometryReader { geo in
            Color.white
                .overlay(self.content)
                .aspectRatio(1.1, contentMode: .fit)
                .cornerRadius(35)
                .offset(x: 0, y: self.percent * geo.size.width)
                .simultaneousGesture(
                    DragGesture(minimumDistance: 0, coordinateSpace: .global)
                        .onChanged { value in
                            let decay: CGFloat = value.translation.height < 0 ? 3 : self.adaptiveDismissable ? 1.2 : 2.5
                            self.percent = value.translation.height / geo.size.width / decay
                            self.time = value.time
                        }
                        .onEnded { value in
                            let decay: CGFloat = value.translation.height < 0 ? 5 : self.adaptiveDismissable ? 1 : 2.5
                            let newPercent = value.translation.height / geo.size.width / decay
                            let speed = Double(newPercent) / (value.time.timeIntervalSinceReferenceDate - self.time.timeIntervalSinceReferenceDate)
                            if self.adaptiveDismissable, newPercent > 0.6 || speed > 40 {
                                self.presentMode.dismiss()
                            } else {
                                withAnimation {
                                    self.percent = 0
                                }
                            }
                        })
                .padding(.all, 5)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                
        }
        .transition(.move(edge: .bottom))
        .edgesIgnoringSafeArea(.all)
        .zIndex(1)
    }
    
    public init(adaptiveDismissable: Bool = true, content: () -> Content) {
        self.adaptiveDismissable = adaptiveDismissable
        self.content = content()
    }
}

struct RoundWidget_Previews: PreviewProvider {
    static var previews: some View {
        RoundWidget {
            EmptyView()
        }
    }
}
