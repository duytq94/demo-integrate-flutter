# Demo Integrate Flutter

## Description

Demo add Flutter to existing Android and iOS native apps.<br/>
There are mutiple options to embed Flutter module in existing app and I'll choose:<br/>

- iOS: Option B - Embed frameworks in Xcode.<br>
Why? Because this option can use $(CONFIGURATION) to dynamic set build mode (debug, release)

- Android: Option A - Depend on the Android Archive (AAR).
  <br/>

These method don't requires other developer working on the project to have a locally installed version of the Flutter SDK to run the project.

## Feature

- Add Flutter to existing native project (Android & iOS).
- Running multiple Flutter instances (different engine, entrypoint) with partial screen & full screen.

## How to run

- Clone this repository.
- Go to Flutter module (duy_flutter_module).
- Run `flutter pub get`, `flutter build aar`, `flutter build ios-framework` to regenerate AAR and Framework files.

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