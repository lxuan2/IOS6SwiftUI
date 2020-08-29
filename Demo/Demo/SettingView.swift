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
    @State private var title = "Setting"
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
                
                IOS6Toggle(isOn: self.$isOn) {
                    IOS6PresetTableCell(image: Image("AppleIDiCloud"), title: "iCloud")
                }
                .ios6FormCellPosition(.mid)
                .ios6ToggleColor(Color(red: 255.0/255.0, green: 127.0/255.0, blue: 2.0/255.0))
                
                IOS6NavigationLink(destination: SettingView()) {
                    IOS6PresetTableCell(image: Image("AppleIDMessages"), title: "Messages", comment: "New Messages")
                }.ios6FormCellPosition(.mid)
                
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
                IOS6Toggle(isOn: self.$isOn) {
                    IOS6PresetTableCell(image: Image("AppleIDiCloud"), title: "iCloud")
                }
                .ios6FormCellPosition(.top)
                .ios6ToggleColor(Color(red: 255.0/255.0, green: 127.0/255.0, blue: 2.0/255.0))
                
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
                    RoundWidget(adaptiveDismissable: true)
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
        .ios6NavigationTitle(self.title)
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

struct RoundWidget: View {
    @State private var percent: CGFloat = 0
    @State private var time: Date = Date()
    @Environment(\.ios6PresentationMode) private var presentMode
    var adaptiveDismissable: Bool = true
    
    @ViewBuilder var body: some View {
        Color.black.opacity(0.4)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
            .zIndex(0)
        
        GeometryReader { geo in
            DismissView()
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
}
