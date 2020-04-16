import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform = const MethodChannel('com.duytq.demointegrateflutter');
  String _batteryLevel = 'Unknown battery level';
  String _param = "Unknow param";

  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
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
      final String result = await platform.invokeMethod('getParam');
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
    platform.invokeMethod('exitFlutter');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Screen"),
        centerTitle: true,
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
            RaisedButton(
              child: Text('Exit Flutter'),
              onPressed: _exitFlutter,
            ),
          ],
        ),
      ),
    );
  }
}
