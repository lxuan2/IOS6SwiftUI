# IOS6SwiftUI

An implementation of IOS 6 UI using SwiftUI. This implementation takes advantages of SwiftUI autolayout and can automatic adapt to any screen size.

## Features:
- \[x]  IOS6NavigationView
- \[x]  IOS6NavigationLink
- \[x]  IOS6NavigationLinkItem
- \[x]  IOS6Form
- \[x]  IOS6Section
- \[x]  IOS6Toggle / IOS6ToggleItem
- \[x]  iIOS6Divider

## Upcoming Features
- \[ ] Swiping back gesture in navigation view
- \[ ] iPad Double Column NavigationView Style


## Installation

In Xcode 11 or grater, in you project, select: `File > Swift Packages > Add Pacakage Dependency`.

Copy the address from github into search bar and hit the enter key. For more details, just google **Add Swift Package in Xcode**

##  How to Use

Everything listed in the Feature section are useable. Here is an recommended implementation:  

```Swift
import SwiftUI
import IOS6SwiftUI

struct ContentView: View {
    @State private var isOn = false
    
    var body: some View {
        IOS6NavigationView("Settings") {
            IOS6Form {
                IOS6Section {
                    IOS6ToggleItem(isOn: self.$isOn, image: Image("AppleIDAppstore"), title: "Messages")
                    
                    IOS6NavigationLink(title: "Settings", destination: {FormView()}) {
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
