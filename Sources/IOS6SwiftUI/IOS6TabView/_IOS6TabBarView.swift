//
//  _IOS6TabBarView.swift
//  IOS6
//
//  Created by Xuan Li on 6/16/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI

struct _IOS6TabBarView: View {
    @Binding var selection: Int
    @Binding var items: [_IOS6TabItemData]
    let safeBottomHeight: CGFloat
    let height: CGFloat
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.15)
                .zIndex(0)
            
            Stepper(onIncrement: {
                self.selection += 1
            }, onDecrement: {
                self.selection -= 1
            }, label: {
                Text("Selection Number: \(selection)")
            })
                .padding(.bottom, safeBottomHeight)
        }
        
            .frame(height: safeBottomHeight + height)
    }
}

struct _IOS6TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        _IOS6TabBarView(selection: .constant(0), items: .constant(.init()), safeBottomHeight: 0, height: 50)
    }
}
