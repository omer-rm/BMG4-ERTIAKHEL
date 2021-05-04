import 'dart:io';

import 'package:Artizakel/Models/product.dart';
import 'package:Artizakel/Provider/ProviderHandler.dart';
import 'package:Artizakel/main.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class AddProductScrreen extends StatefulWidget {
  @override
  _AddProductScrreenState createState() => _AddProductScrreenState();
}

class _AddProductScrreenState extends State<AddProductScrreen> {
  var _editedProduct = Product(
    id: null,
    title: '',
    price: '0',
    description: '',
  );

  var _initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };

  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  bool isloading = false;
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
            onPressed: () {
              //  add products to data base
              inserProductToDataBase(
                  context,
                  _editedProduct.title,
                  _editedProduct.price,
                  _editedProduct.description,
                  _editedProduct.imageUrl);
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: _initValues['title'],
                decoration: InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please provide a value.';
                  }
                  return null;
                },
                onSaved: (value) {},
              ),
              TextFormField(
                initialValue: _initValues['price'],
                decoration: InputDecoration(labelText: 'Price'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a price.';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number.';
                  }
                  if (double.parse(value) <= 0) {
                    return 'Please enter a number greater than zero.';
                  }
                  return null;
                },
                onSaved: (value) {},
              ),
              TextFormField(
                initialValue: _initValues['description'],
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                focusNode: _descriptionFocusNode,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a description.';
                  }
                  if (value.length < 10) {
                    return 'Should be at least 10 characters long.';
                  }
                  return null;
                },
                onSaved: (value) {},
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(
                      top: 8,
                      right: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.grey,
                      ),
                    ),
                    child: _imageUrlController.text.isEmpty
                        ? (isloading ? Text("Loading..") : Text("no data"))
                        : FittedBox(
                            child: Image.network(
                              _imageUrlController.text,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      uploadImage();
                    },
                    child: Text(
                      "select image",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ],
              ),
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
        ],
      ),
    );
  }

  void inserProductToDataBase(BuildContext context, String title, String price,
      String dis, String imageUrl) {
    var userPrvider = Provider.of<ProviderHandler>(context, listen: false);
    Map productsMap = {
      "Title": title,
      "price": price,
      "discriptopn": dis,
      "imageUrl": imageUrl
    };
    if (userPrvider.cuerrentUser != null) {
      productRef.child(userPrvider.cuerrentUser.uid).set(productsMap);
    }
  }

  void uploadImage() async {
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();
    PickedFile image;
    // check for perimssions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;
    if (permissionStatus.isGranted) {
      // select image
      image = await _picker.getImage(source: ImageSource.gallery);
      var file = File(image.path);
      if (image != null) {
        // upload to firebase

        var snapshot =
            await _storage.ref('uploads/${image.path}.png').putFile(file);

        var downloadUrl = await snapshot.ref.getDownloadURL();

        setState(() {
          _imageUrlController.text = downloadUrl;
          _editedProduct = Product(
            title: _editedProduct.title,
            price: _editedProduct.price,
            description: _editedProduct.description,
            imageUrl: _imageUrlController.text,
            id: _editedProduct.id,
            isFavorite: _editedProduct.isFavorite,
          );
        });
      } else {
        print("no image resived");
      }
    } else {
      print("Grant and try again ");
    }
  }
}
