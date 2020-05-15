# IOS6SwiftUI

An implementation of IOS 6 UI using SwiftUI. This implementation takes advantages of SwiftUI autolayout and can automatic adapt to any screen size.

## Features
### View
- \[x]  IOS6NavigationView
- \[x]  IOS6NavigationLink
- \[x]  IOS6Toggle
- \[x]  IOS6Form
- \[x]  IOS6FormRow
- \[x]  IOS6Section

### Modifer
- \[x]  present
- \[x]  ios6NavigationBarTitle
- \[x]  ios6FormRowPos

### Environment Key
- \[x]  presentMode
- \[x]  ios6ToggleColor

### Style
- \[x]  IOS6ToggleStyle
- \[x]  IOS6NavigationBackButtonStyle

## Upcoming Features
- \[ ] generalize all items not to list
- \[ ] IOS6Button
- \[ ] Fix toggle to extended touch area
- \[ ] Enable presentation mode to dismiss view
- \[ ] iPad Double Column NavigationView Style
- \[ ] More Navigation Styles (eg. Map)

## Finished Tasks
- \[x] Combine IOS6NavigationLinkItem and IOS6ToggleItem into IOS6FormRow
- \[x] update IOS6Toggle API
- \[x] ios6NavigationBarTitle modifer
- \[x] anti refresh
- \[x] without section, navigation links give correct the shape

## Installation

In Xcode 11 or greater, in you project, select: `File > Swift Packages > Add Pacakage Dependency`.

Copy the address from github into search bar and hit the enter key. For more details, just google **Add Swift Package in Xcode**

##  How to Use

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
                        IOS6FormRow(image: Image("AppleIDiCloud"), title: "iCloud")
                    }
                    .ios6FormRowPos(.top)
                    .environment(\.ios6ToggleColor, Color(red: 255.0/255.0, green: 127.0/255.0, blue: 2.0/255.0))
                    
                    IOS6NavigationLink(destination: {Text("Messages").ios6NavigationBarTitle("Messages")}, sectionPostion: .medium) {
                        IOS6FormRow(image: Image("AppleIDMessages"), title: "Messages")
                    }
                    
                    IOS6NavigationLink(destination: {Text("FaceTime").ios6NavigationBarTitle("FaceTime")}, sectionPostion: .bottom) {
                        IOS6FormRow(image: Image("AppleIDFaceTime"), title: "FaceTime")
                    }
                }
            }
            .ios6NavigationBarTitle("Demo")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
```
