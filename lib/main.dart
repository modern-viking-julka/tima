import 'package:flutter/material.dart';
import 'package:tima/pages/main_page.dart';
import 'package:flutter/services.dart';

void main() {
  // Landscape off
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'TiMa TimeManager',
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}
