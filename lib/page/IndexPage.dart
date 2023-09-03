import 'package:flutter/material.dart';
import 'package:untitled3/page/HomePage.dart';
import 'package:untitled3/page/NotificationPage.dart';
import 'package:untitled3/page/ProfilePage.dart';
import 'package:untitled3/page/ScenesPage.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {

  int _currentIndex = 0;

  void onTap(index){
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    List _jiemian=[
      HomePage(),
      ScenesPage(),
      NotificationPage(),
      ProfilePage(),
    ];

    return Scaffold(
      body: _jiemian[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.red,
        unselectedItemColor: Colors.black,
        currentIndex: _currentIndex,
        onTap: onTap,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.sanitizer),label: "Scenes"),
          BottomNavigationBarItem(icon: Icon(Icons.notification_important_outlined),label: "Notification"),
          BottomNavigationBarItem(icon: Icon(Icons.auto_fix_normal_outlined),label: "Profile"),
        ],
      ),
    );
  }
}
