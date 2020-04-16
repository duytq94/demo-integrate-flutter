# Demo Integrate Flutter

## Description
Demo add Flutter to existing Android and iOS native apps.<br/>
There are mutiple options to embed flutter module in existing app and I'll choose:<br/>
* iOS: Option A - Embed with CocoaPods and the Flutter SDK
* Android: Option B - Depend on the module’s source code<br/>

These method requires every developer working on the project to have a locally installed version of the Flutter SDK but it allows rapid iteration with the most up-to-date version of your Flutter module without running additional commands.

## How to run
* Clone this repository.
* Go to flutter module (duy_flutter_module)
* Run `flutter pub get && flutter build aar` to regenerate the .ios/ and packages this module as a generic local Maven repository 

##### Android
* Open ./android folder by Android Studio then run the app as usual.

##### iOS
* Go to ./ios folder 
* Run `pod install` command
* Open .xcworkspace file to run the app by Xcode