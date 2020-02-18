# MLKit-iOS
Implementation of MLKit with apple's iOS image classification project

# Build
Requires [cocoapods](https://guides.cocoapods.org/using/getting-started.html) to use.
Clone the repo and cd into the folder.
```
cd ./MLkit-iOS
pod install
open MLKit-iOS.xcworkspace/
```
May need to change the team under MLKit project file (Signing & Capabilities)
* Initial run asks for photo library access, press "Ok" to accept
* run the application again.

# Project Structure
Most files remain default, with a couple changes.
* MLKitModel handles image processing and labelling evaluation. 
* ContentView is the swiftUI implementation that has images and labels.

