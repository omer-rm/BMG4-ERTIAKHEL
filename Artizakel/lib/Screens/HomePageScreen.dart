import 'package:Artizakel/Screens/TapedScreens/HomeTapedScreen.dart';
import 'package:Artizakel/Screens/TapedScreens/addProductTapedScreen.dart';
import 'package:Artizakel/Screens/TapedScreens/mapTapedScreen.dart';
import 'package:Artizakel/Screens/TapedScreens/profileTapedScreen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isMainScreen = true;
  int _currentIndex = 0;
  final List<Widget> _children = [
    HomeTapedScreen(),
    AddProductTapedScreen(),
    ProfileTapedScreen(),
    MapTapedScreen(),
  ];
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      if (_currentIndex != 0) {
        isMainScreen = false;
      } else {
        isMainScreen = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        centerTitle: true,
        title: Text(
          "ARTIZAKHL",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        actions: [
          isMainScreen
              ? IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () => print("obaject"),
                )
              : Container(),
        ],
        leading: isMainScreen
            ? IconButton(
                icon: Icon(Icons.message), onPressed: () => print("object"))
            : Container(),
      ),
      body: Center(
        child: _children.elementAt(_currentIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: onTabTapped,
        backgroundColor: Colors.brown,
        currentIndex:
            _currentIndex, // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.add),
            title: new Text('add product'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.map),
            title: new Text('map'),
          ),
        ],
      ),
    );
  }
}
