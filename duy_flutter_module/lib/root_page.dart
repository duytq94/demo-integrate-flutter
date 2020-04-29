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

  Widget currentScreen;

  @override
  void initState() {
    super.initState();
    PlatformChannel.setMethodCallHandler(_triggerFromNative);
  }

  Future<void> _triggerFromNative(MethodCall call) async {
    if (call.method == "notifyNavToFlutter") {
      switch (call.arguments) {
        case HOME:
          setState(() {
            currentScreen = HomePage();
          });
          break;
        case DETAIL:
          setState(() {
            currentScreen = DetailPage();
          });
          break;
      }
    } else {
      print("Another call method");
    }
  }

  @override
  Widget build(BuildContext context) {
    return currentScreen;
  }
}
