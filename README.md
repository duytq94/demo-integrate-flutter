# Demo Integrate Flutter

## Description
Demo add Flutter to existing Android and iOS native apps.<br/>
There are mutiple options to embed flutter module in existing app and I'll choose:<br/>
* iOS: Option C - Embed application and plugin frameworks in Xcode and Flutter framework with CocoaPods
* Android: Option A - Depend on the Android Archive (AAR)<br/>

These method don't requires other developer working on the project to have a locally installed version of the Flutter SDK to run the project.

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

## Demo
https://youtu.be/rEfIceRjEvs

## Note about Caching and Pre-warm FlutterEngine
* Cache help you load Flutter faster from the 2nd onwards
* Pre-warm help you warm up a FlutterEngine before arriving
* But pre-warm execute entire your flutter screen (initState, build...), so if you need some param from native code before doing an action in flutter (e.g. get accessToken from native to load data from api in dart) you can't put your fetch api function in initState as normal
* At this time, you need a trigger from native code to execute fetch api function in dart (invoke in MethodChannel from native code and setMethodCallHandler in dart code to do this)