# Demo Integrate Flutter

## Description

Demo add Flutter to existing Android and iOS native apps.<br/>
There are multiple options to embed Flutter module in existing app and I'll choose:<br/>

- iOS: Option B - Embed frameworks in Xcode.<br>
Why? Because this option can use $(CONFIGURATION) to dynamically set build mode (debug, release), and later you can push and get these frameworks through any storage (like S3) by pod file. This is suitable for multi-platform development scenarios because a native iOS developer doesn't need to pull and know about Flutter module, it's just a framework to get through pod file like other iOS libs.

- Android: Option A - Depend on the Android Archive (AAR).<br>
This option allows your team to build the host app without installing the Flutter SDK. You can then distribute the artifacts from a local or remote repository (similar framework in iOS).


## Feature

- Add Flutter to existing native project (Android & iOS).
- Running multiple Flutter instances (different engine, entrypoint) with partial screen & full screen.

## How to run

- Clone this repository.
- Go to Flutter module (duy_flutter_module).
- Run `flutter pub get`, `flutter build aar`, `flutter build ios-framework` to regenerate AAR and Framework files.
- You must run these command every time you make code changes in your Flutter module to see affect when run in native.

### Android

- Open ./android folder by Android Studio then run the app as usual.

### iOS

- Go to ./ios folder.
- Run `pod install` command.
- Open .xcworkspace file to run the app by Xcode.

## Demo

https://youtu.be/8u6MEziPCdY

## Screenshots

<img src="screenshots/android.gif" alt= "android" height="500">
<img src="screenshots/ios.gif" alt= "ios" height="500">