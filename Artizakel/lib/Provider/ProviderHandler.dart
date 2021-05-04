import 'package:Artizakel/Models/product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProviderHandler extends ChangeNotifier {
  User cuerrentUser;

  List<Product> productsList = [];
  void updateUserData(User user) {
    cuerrentUser = user;
    notifyListeners();
  }

  void updateProductsList(List productList) {
    productsList = productsList;

    notifyListeners();
  }
}
