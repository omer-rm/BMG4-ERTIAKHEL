import 'package:Artizakel/Provider/ProviderHandler.dart';
import 'package:Artizakel/Screens/AuthenticationScreen.dart';
import 'package:Artizakel/Screens/addNewProductScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddProductTapedScreen extends StatefulWidget {
  @override
  _AddProductTapedScreenState createState() => _AddProductTapedScreenState();
}

class _AddProductTapedScreenState extends State<AddProductTapedScreen> {
  @override
  Widget build(BuildContext context) {
    var currentuser =
        Provider.of<ProviderHandler>(context, listen: false).cuerrentUser;
    return currentuser == null
        ? AuthenticationScreen()
        : Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  // ignore: deprecated_member_use
                  child: RaisedButton(
                    color: Colors.brown,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddProductScrreen(),
                          ));
                    },
                    child: Text(
                      "add a new product",
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
