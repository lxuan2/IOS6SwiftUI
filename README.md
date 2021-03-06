# IOS6SwiftUI

![swift v5.1](https://img.shields.io/badge/swift-v5.1-orange)
![platform iOS](https://img.shields.io/badge/platform-iOS-brightgreen)
![deployment target iOS 13](https://img.shields.io/badge/deployment%20target-iOS%2013-brightgreen)

A packge that provides IOS6 style UI elements. Mainly implemented with SwiftUI and similar behaviors as SwiftUI.

<img src="/example.png" width=300 align=right>

## Public API
### View
- \[x]  IOS6NavigationView
- \[x]  IOS6NavigationLink
- \[x]  IOS6RootView
- \[x]  IOS6TabView
- \[x]  IOS6Form
- \[x]  IOS6List
- \[x]  IOS6Slider
- \[x]  IOS6Badge
- \[x]  IOS6ListBadge

### Modifer
- \[x]  ios6RootBackground
- \[x]  ios6StatusBar
- \[x]  ios6FormCellPosition
- \[x]  ios6FormSectionFont
- \[x]  ios6FormSectionFontBold
- \[x]  ios6ListSectionHeader
- \[x]  ios6SliderStyle
- \[x]  ios6TabBarStyle
- \[x]  ios6TabItem
- \[x]  ios6Tag
- \[x]  ios6NavigationTitle
- \[x]  ios6ForegroundColor
- \[x]  present
- \[x]  scaledFont
- \[x]  etched

### Environment Key
- \[x]  ios6PresentationMode

### Style
**ButtonStyle**
- \[x]  IOS6DefaultButtonStyle
- \[x]  IOS6FormButtonStyle
- \[x]  IOS6ListButtonStyle

**ToggleStyle**
- \[x]  IOS6ToggleStyle

**IOS6TabBarStyle**
- \[x]  IOS6BlueDiamondTabBarStyle

**IOS6TabBarStyle**
- \[x]  IOS6BlueSliderStyle

**IOS6NavigationViewStyle**
- \[x]  IOS6StackNavigationViewStyle
- \[x]  IOS6DoubleColumnNavigationViewStyle

**IOS6NavigationAppearance**
- \[x]  IOS6BlueNavigationAppearance
- \[x]  IOS6GrayNavigationAppearance

### Protocol
- \[x]  IOS6TabBarStyle
- \[x]  IOS6SliderStyle
- \[x]  IOS6NavigationViewStyle
- \[x]  IOS6NavigationAppearance

### Preset view (Recommanded)
- \[x]  IOS6PresetTableCell
- \[x]  IOS6PresetSignBadge

---
## Availability
Device: iPhone and iPad
System: IOS 13.0.0 ~ IOS 13.6.1. ( IOS 14 has not been tested yet. )

## Installation
In Xcode 11 or greater, under your project, select: `File > Swift Packages > Add Pacakage Dependency`. 
Copy the address from github into search bar and hit the enter key. For more details, just google **Add Swift Package in Xcode**

##  How to Use
(Suggestions: Preset views are recommanded pre-implemented elements. Designed for saving time.)

Everything listed in the Feature section are useable. Here is an recommended implementation:  

```Swift
import SwiftUI
import IOS6SwiftUI

struct ContentView: View {
    @State private var isOn = false
    @State private var progess = 0.0
    
    var body: some View {
        IOS6RootView {
            IOS6NavigationView {
                IOS6Form {
                    Section(header: Text("App:").ios6FormSectionFontBold(), footer: Text("This is the comment").ios6FormSectionFont()) {
                        IOS6Slider(value: self.$progess)
                            .ios6FormCellPosition(.top)
                        
                        IOS6Toggle(isOn: self.$isOn) {
                            IOS6PresetTableCell(image: Image("AppleIDiCloud"), title: "iCloud")
                        }
                        .ios6FormCellPosition(.mid)
                        .ios6ToggleColor(Color(red: 255.0/255.0, green: 127.0/255.0, blue: 2.0/255.0))
                        
                        IOS6NavigationLink(destination: Text("Game Center").ios6NavigationBarTitle("Game Center")) {
                            IOS6PresetTableCell(image: Image("AppleIDMessages"), title: "Messages", comment: "New Messages")
                        }.ios6FormCellPosition(.mid)
                        
                        IOS6NavigationLink(destination: Text("FaceTime").ios6NavigationBarTitle("FaceTime")) {
                            IOS6PresetTableCell(image: Image("AppleIDFaceTime"), title: "FaceTime", comment: IOS6ListBadge(text: "1"))
                        }.ios6FormCellPosition(.mid)
                        
                        IOS6NavigationLink(destination: Text("Game Center").ios6NavigationBarTitle("Game Center")) {
                            IOS6PresetTableCell(image: Image("AppleIDGameCenter"), title: "Game Center")
                        }.ios6FormCellPosition(.bottom)
                    }
                }
                .ios6NavigationBarTitle("Demo")
            }
        }
    }
}
```
---
## Upcoming Features
- \[ ] Optimize for IOS 14
- \[ ] Add notification icon to tab item

## Finished Tasks
- \[x] Archive v.1.0.0 [passed]
- \[x] More Navigation Styles (eg. Map)
- \[x] iPad Double Column NavigationView Style
- \[x] Reimplement IOS6NavigationView and improve efficiency
- \[x] Test IOS6Slider init and fix min/max label and add onEditChange
- \[x] add ios6SliderStyle
- \[x] Fix IOS6Slider range and adopt new APIs
- \[x] Allow tab item changing on time
- \[x] Add an example project
- \[x] Add tag, ios6tabview now memorize loaded view
- \[x] Add IOS6TabBarStyle
- \[x] Add more documents
- \[x] fix toggle disable mode
- \[x] Fix over extended toggle touch area
- \[x] Add IOS6List
- \[x] Undismissable sheet
- \[x] present customized system model
- \[x] allow multi-modal in same level
- \[x] set private framework
- \[x] bring presentMode to IOS6NavigationView
- \[x] add disabled navigation control
- \[x] rename IOS6FormRow to IOS6TableCell
- \[x] ios6ForegroundColor, IOS6FormRowAdv
- \[x] Test modal is enabled at start
- \[x] present Model
- \[x] generalize all items not to list
- \[x] IOS6Button
- \[x] Combine IOS6NavigationLinkItem and IOS6ToggleItem into IOS6FormRow
- \[x] update IOS6Toggle API
- \[x] ios6NavigationBarTitle modifer
- \[x] anti refresh
- \[x] without section, navigation links give correct the shape
