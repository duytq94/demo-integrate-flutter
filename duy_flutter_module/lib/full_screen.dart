import 'package:duyfluttermodule/root_page.dart';
import 'package:flutter/material.dart';

class FullScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RootPage(),
    );
  }
}
