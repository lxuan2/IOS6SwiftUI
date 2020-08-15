//
//  ContentView.swift
//  Demo
//
//  Created by Xuan Li on 8/13/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI
import IOS6SwiftUI

struct ContentView: View {
    @State private var disable = false
    @State private var selection: Int = 2
    @State private var isOn = false
    
    var body: some View {
        IOS6RootView {
            IOS6TabView() {
                IOS6NavigationView {
                    SettingView()
                }
                .ios6TabItem("Navigation", systemImage: "square.stack.3d.down.right")
                .ios6Tag(0)
                
                IOS6NavigationView {
                    ListView()
                }
                .ios6TabItem("List", systemImage: "list.number", insets: .init(top: 1, leading: 1, bottom: 1, trailing: 1))
                .ios6Tag(1)
                
                MaterialView()
                .ios6TabItem("iCloud", systemImage: "icloud")
                .ios6Tag(2)
                
                ZStack {
                    Image("sds").resizable().edgesIgnoringSafeArea(.all)
                    BlurSegmentedPicker(selection: self.$selection) {
                        Text("Years").pickerTag(0)
                        
                        Text("Months").pickerTag(1)
                        
                        Text("Days").pickerTag(2)
                        
                        Text("All Photos").pickerTag(3)
                    }
                    VStack {
                        Text("\(self.selection)")
                        Spacer()
                    }
                }
                .ios6TabItem("Person", systemImage: "person.crop.square")
                .ios6Tag(3)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
