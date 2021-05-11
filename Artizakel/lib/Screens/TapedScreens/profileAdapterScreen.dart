import 'package:Artizakel/Provider/ProviderHandler.dart';
import 'package:Artizakel/Screens/AuthenticationScreen.dart';
import 'package:Artizakel/Screens/TapedScreens/profileTapedScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileAdapterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var currentuser =
        Provider.of<ProviderHandler>(context, listen: false).cuerrentUser;
    return currentuser == null ? AuthenticationScreen() : ProfileTapedScreen();
  }
}
