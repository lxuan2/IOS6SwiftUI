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
    let height: CGFloat = 50
    
    var body: some View {
        ZStack {
            Color.black
                .overlay(topLayer, alignment: .top)
                .overlay(Rectangle().fill(Color.white.opacity(0.18)).frame(height: 0.5).padding(.top, 1), alignment: .top)
                .edgesIgnoringSafeArea(.all)
                .zIndex(0)
            
            HStack(spacing: 0) {
                ForEach(items) { item in
                    Button(action: {
                        self.selection = self.items.firstIndex(of: item)!
                    }) {
                        item.label()
                            .environment(\._ios6IsSelected, self.selection == self.items.firstIndex(of: item)!)
                    }.buttonStyle(NoButtonStyle())
                }
            }
        }.frame(height: height)
    }
    
    var topLayer: some View {
        LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.2), Color.white.opacity(0.1)]), startPoint: .top, endPoint: .bottom)
            .frame(height: height / 2)
            .padding(.top, 1)
    }
}

struct _IOS6TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        _IOS6TabBarView(selection: .constant(0), items: .constant(.init()))
    }
}

struct NoButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}
