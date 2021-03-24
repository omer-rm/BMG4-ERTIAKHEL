import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String txt = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextField(
            textAlign: TextAlign.end,
            decoration: (InputDecoration(
              hintText: 'search in ARTIZAHKEL',
              filled: true,
              fillColor: Colors.white,
            )),
            autofocus: true,
            cursorColor: Colors.white,
            onChanged: (String str) {
              txt = str;
              print(txt);
            }),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.mic,
              color: Colors.grey,
            ),
            tooltip: 'Open Microphone',
            onPressed: null,
          ),
        ],
        // when clicked on the textfield this icon dissapears
      ),
      body: const Center(
        child: Text(
          'no results now ',
          style: TextStyle(fontSize: 26, color: Colors.grey),
        ),
      ),
    );
  }
}
