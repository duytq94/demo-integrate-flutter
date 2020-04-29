import 'package:duyfluttermodule/root_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _batteryLevel = 'Unknown battery level';
  String _param = "Unknow param";

  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await PlatformChannel.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level at $result%.';
      print(batteryLevel);
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'";
      print(batteryLevel);
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  Future<void> _getParam() async {
    String param;
    try {
      final String result = await PlatformChannel.invokeMethod('getParam');
      param = result;
      print(param);
    } on PlatformException catch (e) {
      param = "Failed to get param: '${e.message}'";
      print(param);
    }

    setState(() {
      _param = param;
    });
  }

  void _exitFlutter() {
    PlatformChannel.invokeMethod('exitFlutter');
  }

  @override
  Widget build(BuildContext context) {
    print("duyduy build HomePage");
    return Scaffold(
      appBar: AppBar(
        title: Text("Home page"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: _exitFlutter,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RaisedButton(
              child: Text('Get Battery Level'),
              onPressed: _getBatteryLevel,
            ),
            Text(_batteryLevel),
            RaisedButton(
              child: Text('Get Param'),
              onPressed: _getParam,
            ),
            Text(_param.toString()),
          ],
        ),
      ),
    );
  }
}
