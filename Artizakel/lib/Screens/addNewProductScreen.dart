import 'package:flutter/material.dart';

class AddProductScrreen extends StatefulWidget {
  @override
  _AddProductScrreenState createState() => _AddProductScrreenState();
}

class _AddProductScrreenState extends State<AddProductScrreen> {
  String dropdownValue = 'Electrical';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Text("Adding  a new product"),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () => print("deneme"),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Title'),
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please provide a value.';
                }
                return null;
              },
              onSaved: (value) {},
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'price'),
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please provide a value.';
                }
                return null;
              },
              onSaved: (value) {},
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'discription'),
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please provide a value.';
                }
                return null;
              },
              onSaved: (value) {},
            ),
            selectImagePosition(),
            SizedBox(height: 15),
            Row(
              children: [
                Text("Type", style: TextStyle(fontSize: 15)),
                SizedBox(width: 20),
                DropdownButton<String>(
                  value: dropdownValue,
                  icon: const Icon(Icons.keyboard_arrow_down_outlined),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownValue = newValue;
                    });
                  },
                  items: <String>[
                    'Electrical',
                    'decoration',
                    'Houseware',
                    'Other'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget selectImagePosition() {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            height: 150,
            width: 150,
            color: Colors.grey,
          ),
          SizedBox(
            width: 25,
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text(
              "select image",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
