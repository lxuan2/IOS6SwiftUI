//
//  MovableCardView.swift
//  animation
//
//  Created by Xuan Li on 12/14/19.
//  Copyright © 2019 Xuan Li. All rights reserved.
//

import SwiftUI

struct MovableCardView: View {
    @State private var dragAmount = CGSize.zero
    @State private var scaleAmount: CGFloat = 1
    @GestureState private var didLongPress: Bool = false
    @State private var didDrag: Bool = false

    var body: some View {
        ZStack {
            
            ZStack{
                LinearGradient(gradient: Gradient(colors: [.yellow, .red]), startPoint: .topLeading, endPoint: .bottomTrailing)
                Text("")
                    .foregroundColor(.white)
                    .font(.system(size: 150))
            }
                .frame(width: 300, height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .scaleEffect(didLongPress || didDrag ? 1.1 : 1)
                .gesture(
                    LongPressGesture(minimumDuration: .infinity)
                        .updating($didLongPress){value, state, transcation in
                                state = value
                    }
                ).animation(.interpolatingSpring(stiffness: 200, damping: 10))
                .offset(dragAmount)
                .gesture(
                    DragGesture()
                        .onChanged{
                            self.dragAmount = $0.translation
                            self.didDrag = true
                    }
                        .onEnded{ _ in
                            withAnimation(.interpolatingSpring(stiffness: 200, damping: 10)) {
                                self.dragAmount = CGSize.zero
                                self.didDrag = false
                            }
                    }
                )
            
        }
    }
}

struct MovableCardView_Previews: PreviewProvider {
    static var previews: some View {
        MovableCardView()
    }
}
