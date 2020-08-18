//
//  ListView.swift
//  IOS6
//
//  Created by Xuan Li on 7/2/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI
import IOS6SwiftUI

struct ListView: View {
    @State private var swiftuiTrans = false
    @State private var systemModal = false
    @State private var cusTrans = false
    @State private var fixedSheet = false
    
    @State private var fixedSheetAllowDismiss = false
    @State private var swiftuiTransAllowDismiss = true
    @State private var systemModalStyle: UIModalPresentationStyle = .overFullScreen
    
    @Environment(\.ios6PresentationMode) var presentMode
    
    var body: some View {
        IOS6List(bgC: self.listColor, cellBgC: self.listColor) {
            Section(header: Text("SwiftUI").ios6ListSectionHeader()) {
                Button(action: {
                    self.swiftuiTrans = true
                }) {
                    IOS6PresetTableCell(title:"present with SwiftUI transion")
                }
                .present(isPresented: self.$swiftuiTrans, with: .interactiveSpring(response: 0.4)) {
                    RoundWidget(adaptiveDismissable: self.swiftuiTransAllowDismiss)
                }
                .overlay(
                    IOS6NavigationLink(destination: self.swiftuiTransConfigView){
                        IOS6PresetSignBadge(sign: .arrow_blue)
                    }.buttonStyle(IOS6DefaultButtonStyle()), alignment: .trailing)
            }
            
            Section(header: Text("UIKit").ios6ListSectionHeader()) {
                Button(action: {
                    self.systemModal = true
                }) {
                    IOS6PresetTableCell(title:"present with System modal")
                }
                .present(isPresented: self.$systemModal, with: self.systemModalStyle) {
                    DismissView()
                }
                .overlay(
                    IOS6NavigationLink(destination: self.systemConfigView){
                        IOS6PresetSignBadge(sign: .checkmark_green)
                    }.buttonStyle(IOS6DefaultButtonStyle()), alignment: .trailing)
                
                Button(action: {
                    self.cusTrans = true
                }) {
                    IOS6PresetTableCell(title:"present with Customized transion")
                }
                .present(isPresented: self.$cusTrans, given: PartialSheetTransitioningDelegate(from: true, to: true)) {
                    DismissView()
                }
                
                Button(action: {
                    self.fixedSheet = true
                }) {
                    IOS6PresetTableCell(title:"present with Fixed sheet")
                }
                .present(isPresented: self.$fixedSheet, isDismissable: self.$fixedSheetAllowDismiss) {
                    DismissView(allowDismiss: self.$fixedSheetAllowDismiss)
                }
                .overlay(
                    IOS6NavigationLink(destination: self.fixedSheetConfigView){
                        IOS6PresetSignBadge(sign: .arrow_blue)
                    }.buttonStyle(IOS6DefaultButtonStyle()), alignment: .trailing)
            }
            
            IOS6NavigationLink(destination: SettingView()) {
                IOS6PresetTableCell(image: Image("AppleIDMessages"), title: "Messages", comment: "New Messages")
            }
        }.ios6NavigationBarTitle("Modal Presentation")
    }
    
    let listColor = UIColor(red: 247.0/255.0, green: 247.0/255.0, blue: 247.0/255.0, alpha: 1)
    
    var swiftuiTransConfigView: some View {
        IOS6Form {
            IOS6Toggle(isOn: self.$swiftuiTransAllowDismiss) {
                Text("Allow adaptive dismiss")
            }.ios6FormCellPosition(.single)
        }.ios6NavigationBarTitle("Configuration")
    }
    
    var systemConfigView: some View {
        IOS6Form {
            Section(header: Text("Modal Presentation Style").ios6FormSectionFontBold()) {
                Picker(selection: self.$systemModalStyle, label: EmptyView()) {
                    Text("Full Screen")
                        .tag(UIModalPresentationStyle.overFullScreen)
                    Text("Page Sheet")
                        .tag(UIModalPresentationStyle.pageSheet)
                }
                .pickerStyle(SegmentedPickerStyle())
                .ios6FormCellPosition(.single)
            }
        }.ios6NavigationBarTitle("Configuration")
    }
    
    var fixedSheetConfigView: some View {
        IOS6Form {
            IOS6Toggle(isOn: self.$swiftuiTransAllowDismiss) {
                Text("Allow adaptive dismiss")
            }.ios6FormCellPosition(.single)
        }.ios6NavigationBarTitle("Configuration")
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
