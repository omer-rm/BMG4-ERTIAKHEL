import 'package:flutter/material.dart';

class MapTapedScreen extends StatefulWidget {
  @override
  _MapTapedScreenState createState() => _MapTapedScreenState();
}

class _MapTapedScreenState extends State<MapTapedScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "this page well be done after we get the map api from google",
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
