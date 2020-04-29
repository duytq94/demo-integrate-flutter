import 'package:duyfluttermodule/root_page.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  DetailPage({Key key}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  void _exitFlutter() {
    PlatformChannel.invokeMethod('exitFlutter');
  }

  @override
  Widget build(BuildContext context) {
    print("duyduy build DetailPage");
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Page"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: _exitFlutter,
        ),
      ),
      body: Center(child: Text("This is the detail")),
    );
  }
}
