import 'package:flutter/material.dart';
import 'package:tima/pages/home_page.dart';
import 'package:tima/pages/settings_page.dart';
import 'package:tima/pages/testing_page.dart';
import 'package:tima/pages/timeoverview_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  List<Widget> pageList = <Widget>[
    HomePage(),
    TimeOverviewPage(), // TestingPage(),
    Center(child: Text('PDF send')),
    SettingsPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageList[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            label: 'Übersicht',
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.schedule),
            label: 'Stundenplan',
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.attach_email),
            label: 'Send PDF',
          ),
          BottomNavigationBarItem(
              icon: new Icon(Icons.manage_accounts),
              label: 'Einstellungen',
              backgroundColor: Colors.brown)
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
