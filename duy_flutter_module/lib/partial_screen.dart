import 'package:duyfluttermodule/default_page.dart';
import 'package:flutter/material.dart';

class PartialScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Default Page"),
          centerTitle: true,
        ),
        body: DefaultPage(),
      ),
    );
  }
}
