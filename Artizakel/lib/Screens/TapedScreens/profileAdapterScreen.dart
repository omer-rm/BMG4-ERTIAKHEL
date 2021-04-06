import 'package:Artizakel/Screens/AuthenticationScreen.dart';
import 'package:Artizakel/Screens/TapedScreens/profileTapedScreen.dart';
import 'package:flutter/material.dart';

class ProfileAdapterScreen extends StatelessWidget {
  bool isUserAuth = false;

  @override
  Widget build(BuildContext context) {
    return isUserAuth ? ProfileTapedScreen() : AuthenticationScreen();
  }
}
