import 'package:duyfluttermodule/detail_page.dart';
import 'package:duyfluttermodule/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Channel
const CHANNEL = "com.duytq.demointegrateflutter";
const PlatformChannel = const MethodChannel(CHANNEL);

class RootPage extends StatefulWidget {
  RootPage({Key key}) : super(key: key);

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  // Screen route
  static const HOME = "HOME";
  static const DETAIL = "DETAIL";

  Widget currentScreen = Container(child: Center(child: Text('No input from native')));
  String title = "Default Page";

  @override
  void initState() {
    super.initState();
    PlatformChannel.setMethodCallHandler(_triggerFromNative);
  }

  Future<void> _triggerFromNative(MethodCall call) async {
    if (call.method == "notifyNavToFlutter") {
      print("duyduy _triggerFromNative notifyNavToFlutter");
      // Set transparent status bar
      // Not place in build method because it won't work from the second times navigate to Flutter
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ));
      switch (call.arguments) {
        case HOME:
          setState(() {
            title = "Home Page";
            currentScreen = HomePage();
          });
          break;
        case DETAIL:
          setState(() {
            title = "Detail Page";
            currentScreen = DetailPage();
          });
          break;
      }
    } else {
      print("Another call method");
    }
  }

  void _exitFlutter() {
    PlatformChannel.invokeMethod('exitFlutter');
  }

  @override
  Widget build(BuildContext context) {
    print("duyduy build RootPage");
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: _exitFlutter,
        ),
      ),
      body: currentScreen,
    );
  }
}
