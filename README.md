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
- \[x]  ios6NavigationBarTitle
- \[x]  ios6FormRowPos

### Environment Key
- \[x]  ios6ToggleColor

### Style
- \[x]  IOS6ToggleStyle
- \[x]  IOS6NavigationBackButtonStyle

## Upcoming Features
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
import IOS6SwiftUI

struct ContentView: View {
    @State private var isOn = false
    
    var body: some View {
        IOS6NavigationView("Settings") {
            IOS6Form {
                IOS6Section {
                    IOS6ToggleItem(isOn: self.$isOn, image: Image("AppleIDAppstore"), title: "Messages")
                    
                    IOS6NavigationLink(title: "Settings", destination: {Text("FaceTime")}) {
                        IOS6NavigationLinkItem(image: Image("AppleIDMessages"), title: "Messages")
                    }
                    
                    IOS6NavigationLink(title: "FaceTime", destination: {Text("FaceTime")}) {
                        IOS6NavigationLinkItem(image: Image("AppleIDFaceTime"), title: "FaceTime")
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
```
