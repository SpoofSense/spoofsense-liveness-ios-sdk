# spoof-sense-ios

## Requirements

| Platform | Minimum Swift Version | Installation
| --- | --- | --- |
| iOS 13.2+ | 5.0 | [CocoaPods](#cocoapods)

## Installation

### CocoaPods

[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate spoof-sense-ios into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
pod 'SpoofSense'
```

## What this CocoaPod does?
This CocoaPod check the liveness of the scanned face and returns you with a simple resultCallBack.
Guidelines to follow, while scanning your face: 
 - Ample lighting on the face.
 - No face tilt.
 - No multiple face detection.


## SpoofSense Pod Components:
This CocoaPod consist of mainly 3 screens:

```
1 Splash screen
2 Guideline screen
3 Camera screen
```
respectively shown in the below image.

![image](https://user-images.githubusercontent.com/104752632/218302185-0fc9f765-41df-4e6f-853b-34b6f2d0e5c8.jpg)

## Setup

### API Key
Set api in AppDelegate didFinishLaunchingWithOptions. `Note: API Key is Mandatory.`

```swift
SpoofSense.apiKey = "Set_Your_Api_Key"
```

### Pod button properties
This will set the button background color for the entire pod. 

```swift
SpoofSense.buttonTitleColor = .black
SpoofSense.buttonBackgroundColor = .red
```

## Splash Screen

### Set Splash Screen Visibility
You can set the splash screen visibility by simply turning flag true/false. Default is True.

```swift
SpoofSense.showSplashScreen = true
```

### Set button text title
```swift
SpoofSense.splashButtonTextTitle = "Check Liveness"
```

### Set logo image
Supported Size: 40 * 40

```swift
SpoofSense.appLogo = UIImage(named: "yourImage")
```

### Set App name
We have provided support for App First Name and Last Name. You can set Empty String if you want. Also you can set different color for first/last name. 

```swift
SpoofSense.appFirstName = "YourAppFirstName"
SpoofSense.appFirstNameColor = .black
```

```swift
SpoofSense.appLastName = "YourAppFirstName"
SpoofSense.appLastNameColor = .green
```

### Set Version Number
You can set Empty String if you want. Also you can set version number string color. 

```swift
SpoofSense.versionNumberString = ""
SpoofSense.versionNumberColor = .black
```

## Guidelines Screen

### Set Guidelines Screen Visibility
You can set the guidelines screen visibility by simply turning flag true/false. Default is True.

```swift
SpoofSense.showFaceGuidelinesScreen = true
```

### Set button text title
```swift
SpoofSense.guidelinesButtonTextTitle = "Check Liveness"
```

## Launch SpoofSense

Push spoofsense
```swift
SpoofSense.launch(with: Your_Navigation_Controller)
```

Present spoofsense
```swift
SpoofSense.present(with: Your_Navigation_Controller, animated: true)
```


## Get result callback

```
SpoofSense.resultCallBack = { [weak self] (jsonObject) -> Void in
    guard let self = self else { return }
    print("jsonObject: ", jsonObject)
}
```

## License

spoof-sense-ios is released under the MIT license. [See LICENSE](http://www.opensource.org/licenses/MIT) for details.
