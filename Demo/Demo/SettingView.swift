//
//  SettingView.swift
//  IOS6
//
//  Created by Xuan Li on 5/5/20.
//  Copyright © 2020 Xuan Li. All rights reserved.
//

import SwiftUI
import IOS6SwiftUI

struct SettingView: View {
    @State private var isOn = false
    @State private var flag = false
    @State private var flag1 = false
    @State private var flag2 = false
    @State private var flag3 = false
    @State private var allowDismiss = false
    @State private var progess = 0.0
    @Environment(\.ios6PresentationMode) var presentMode
    
    var body: some View {
        IOS6Form {
            Section(header: Text("App:").padding(.top, 17).ios6FormSectionFontBold(), footer: Text("This is the comment").ios6FormSectionFont()) {
                IOS6Slider(value: self.$progess, in: 1...100,
                           minimumValueLabel: Image(systemName: "speaker.fill")
                            .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 5))
                            .foregroundColor(Color(red: 123 / 255.0, green: 123 / 255.0, blue: 123 / 255.0)),
                           maximumValueLabel: Image(systemName: "speaker.3.fill")
                            .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 8))
                            .foregroundColor(Color(red: 123 / 255.0, green: 123 / 255.0, blue: 123 / 255.0)))
                    .ios6FormCellPosition(.top)
                
                Toggle(isOn: self.$isOn) {
                    IOS6PresetTableCell(image: Image("AppleIDiCloud"), title: "iCloud")
                }
                .ios6FormCellPosition(.mid)
                .toggleStyle(IOS6ToggleStyle(tint: Color(red: 255.0/255.0, green: 127.0/255.0, blue: 2.0/255.0)))
                
                IOS6NavigationLink(destination: SettingView()) {
                    IOS6PresetTableCell(image: Image("AppleIDMessages"), title: "Messages", comment: "New Messages")
                }.isDetailLink(true)
                .ios6FormCellPosition(.mid)
                
                IOS6NavigationLink(destination: DismissViewLink()) {
                    IOS6PresetTableCell(image: Image("AppleIDFaceTime"), title: "FaceTime", comment: IOS6ListBadge(text: "1"))
                }.ios6FormCellPosition(.mid)
                
                IOS6NavigationLink(destination: self.refresh) {
                    IOS6PresetTableCell(image: Image("AppleIDGameCenter"), title: "Game Center")
                }.ios6FormCellPosition(.mid)
                
                IOS6NavigationLink(destination: Text("iBooks").ios6NavigationTitle("iBooks")) {
                    IOS6PresetTableCell(image: Image("AppleIDiBooks"), title: "iBooks")
                }.ios6FormCellPosition(.mid)
                
                IOS6NavigationLink(destination: Text("App Store").ios6NavigationTitle("App Store")) {
                    IOS6PresetTableCell(image: Image("AppleIDAppstore"), title: "App Store")
                }.ios6FormCellPosition(.mid)
                
                IOS6NavigationLink(destination: Text("iTunes").ios6NavigationTitle("iTunes")) {
                    IOS6PresetTableCell(image: Image("AppleIDMusicStore"), title: "iTunes")
                }.ios6FormCellPosition(.bottom)
            }
            
            Section(header: Text("App:").ios6FormSectionFontBold()) {
                Toggle(isOn: self.$isOn) {
                    IOS6PresetTableCell(image: Image("AppleIDiCloud"), title: "iCloud")
                }
                .ios6FormCellPosition(.top)
                
                IOS6NavigationLink(destination: SettingView()) {
                    IOS6PresetTableCell(image: Image("AppleIDMessages"), title: "Messages", comment: "New Messages")
                }.ios6FormCellPosition(.mid)
                
                IOS6NavigationLink(destination: DismissViewLink()) {
                    IOS6PresetTableCell(image: Image("AppleIDFaceTime"), title: "FaceTime", comment: IOS6ListBadge(text: "2"))
                }.ios6FormCellPosition(.mid)
                
                IOS6NavigationLink(destination: Text("Game Center").ios6NavigationTitle("Game Center")) {
                    IOS6PresetTableCell(image: Image("AppleIDGameCenter"), title: "Game Center")
                }.ios6FormCellPosition(.mid)
                
                IOS6NavigationLink(destination: Text("iBooks").ios6NavigationTitle("iBooks")) {
                    IOS6PresetTableCell(image: Image("AppleIDiBooks"), title: "iBooks")
                }.ios6FormCellPosition(.mid)
                
                IOS6NavigationLink(destination: Text("App Store").ios6NavigationTitle("App Store")) {
                    IOS6PresetTableCell(image: Image("AppleIDAppstore"), title: "App Store")
                }.ios6FormCellPosition(.mid)
                
                IOS6NavigationLink(destination: Text("iTunes").ios6NavigationTitle("iTunes")) {
                    IOS6PresetTableCell(image: Image("AppleIDMusicStore"), title: "iTunes")
                }.ios6FormCellPosition(.bottom)
            }
            
            Section(header: Text("App:").ios6FormSectionFontBold(), footer: Text("This is the comment").padding(.bottom, 17).ios6FormSectionFont()) {
                Button(action: {
                    self.presentMode.dismiss()
                }) {
                    IOS6PresetTableCell(title:self.presentMode.isPresented ? "Can dismiss" : "no dismiss")
                }.ios6FormCellPosition(.top)
                
                Button(action: {
                    self.flag = true
                }) {
                    IOS6PresetTableCell(title:"present with System modal")
                }
                .ios6FormCellPosition(.mid)
                .present(isPresented: self.$flag, with: .overFullScreen) {
                    DismissView()
                }
                
                Button(action: {
                    self.flag1 = true
                }) {
                    IOS6PresetTableCell(title:"present with SwiftUI transion")
                }
                .ios6FormCellPosition(.mid)
                .present(isPresented: self.$flag1, with: .interactiveSpring(response: 0.4)) {
                    RoundWidget(adaptiveDismissable: true, content: { DismissView() })
                }
                
                Button(action: {
                    self.flag2 = true
                }) {
                    IOS6PresetTableCell(title:"present with Customized transion")
                }
                .ios6FormCellPosition(.mid)
                .present(isPresented: self.$flag2, given: PartialSheetTransitioningDelegate(from: true, to: true)) {
                    DismissView()
                }
                
                Button(action: {
                    self.flag3 = true
                }) {
                    IOS6PresetTableCell(title:"present with Fixed sheet")
                }
                .ios6FormCellPosition(.bottom)
                .present(isPresented: self.$flag3, isDismissable: self.$isOn) {
                    DismissView(allowDismiss: self.$isOn)
                }
            }
        }
        .ios6NavigationTitle("Setting")
    }
    
    var refresh: some View {
        IOS6RefreshView(onRefresh: { sleep(1) }) {
            Color.white.frame(width: 385, height: 200)
        }.ios6NavigationTitle("Refresh View")
    }
}

struct FormView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
