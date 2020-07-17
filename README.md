# IOS6SwiftUI

A packge that provides IOS6 style UI elements. Mainly implemented with SwiftUI and similar behaviors as SwiftUI.

## Public API
### View
- \[x]  IOS6NavigationView
- \[x]  IOS6NavigationLink
- \[x]  IOS6RootView
- \[x]  IOS6TabView
- \[x]  IOS6Button
- \[x]  IOS6Toggle
- \[x]  IOS6Form
- \[x]  IOS6List
- \[x]  IOS6SignLabel
- \[x]  IOS6Slider

### Preset view (Recommanded)
- \[x]  IOS6PresetListCell
- \[x]  IOS6PresetTabItem
- \[x]  IOS6PresetSignLabel

### Modifer
- \[x]  ios6RootBackground
- \[x]  ios6StatusBar
- \[x]  ios6SectionItem
- \[x]  ios6SectionListHeader
- \[x]  ios6SectionFormHeader
- \[x]  ios6SectionFormFooter
- \[x]  ios6TabItem
- \[x]  ios6Tag
- \[x]  ios6NavigationBarTitle
- \[x]  ios6ForegroundColor
- \[x]  ios6ToggleColor
- \[x]  present
- \[x]  scaledFont
- \[x]  etched

### Environment Key
- \[x]  ios6PresentationMode

### Style
- \[x]  IOS6ToggleStyle

---
## Availability
Device: iPhone and iPad
System: IOS 13.0.0 ~ IOS 13.6.0. ( IOS14 has not been tested yet. )

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
    
    var body: some View {
        IOS6NavigationView(interactiveSwipe: true) {
            IOS6Form {
                Section {
                    IOS6Toggle(isOn: self.$isOn) {
                        IOS6PresetListCell(image: Image("AppleIDiCloud"), title: "iCloud")
                    }
                    .ios6SecPosition(.top)
                    .ios6ToggleColor(Color(red: 255.0/255.0, green: 127.0/255.0, blue: 2.0/255.0))
                    
                    IOS6NavigationLink(destination: Text("Messages").ios6NavigationBarTitle("Messages"), sectionPostion: .medium) {
                        IOS6PresetListCell(image: Image("AppleIDMessages"), title: "Messages", comment: "New Messages")
                    }
                    
                    IOS6NavigationLink(destination: Text("FaceTime").ios6NavigationBarTitle("FaceTime"), sectionPostion: .bottom) {
                        IOS6PresetListCell(image: Image("AppleIDFaceTime"), title: "FaceTime", comment: self.commentIcon)
                    }
                }
            }
            .ios6NavigationBarTitle("Demo")
        }
    }
    
    var commentIcon: some View {
        Capsule()
            .fill(Color.white)
            .ios6ForegroundColor(Color(red: 0.7, green: 0.7, blue: 0.7))
            .overlay(
                Text("1")
                    .fontWeight(.medium)
                    .ios6ForegroundColor(regular: .white,
                                         active: Color(red: 44.0/255.0,
                                                       green: 108.0/255.0,
                                                       blue: 234.0/255.0)))
            .frame(maxWidth: 33, maxHeight: 22.5)
    }
}
```
---
## Upcoming Features
- \[ ] Add an example project
- \[ ] IOS6Alert
- \[ ] IOS6ActionSheet
- \[ ] Archive final version for IOS13 and start IOS14 development
- \[ ] iPad Double Column NavigationView Style
- \[ ] More Navigation Styles (eg. Map)

## Finished Tasks
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
