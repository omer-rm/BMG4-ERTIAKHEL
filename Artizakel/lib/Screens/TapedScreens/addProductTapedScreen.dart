import 'package:Artizakel/Screens/addNewProductScreen.dart';
import 'package:flutter/material.dart';

class AddProductTapedScreen extends StatefulWidget {
  @override
  _AddProductTapedScreenState createState() => _AddProductTapedScreenState();
}

class _AddProductTapedScreenState extends State<AddProductTapedScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
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
                style: TextStyle(fontSize: 25),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
