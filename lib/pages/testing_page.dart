import 'package:flutter/material.dart';

class TestingPage extends StatefulWidget {
  @override
  _TestingPageState createState() => _TestingPageState();
}

class _TestingPageState extends State<TestingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Testing Form',
            style: TextStyle(color: Colors.blue),
          ),
          backgroundColor: Colors.black,
        ),
        body: Center(child: Text('Testing Page!')));
  }
}
