import 'dart:convert';
import 'package:Artizakel/Models/chats.dart';
import 'package:Artizakel/Models/product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProviderHandler extends ChangeNotifier {
  User cuerrentUser;
  String userId;
  List<Product> productsList = [];

  List<Chats> chatList = [];
  void updateUserData(User user) {
    cuerrentUser = user;
    notifyListeners();
  }

  void updateProductsList(List productList) {
    productsList = productsList;

    notifyListeners();
  }

  List<Product> _items = [];
  var _showFavoritesOnly = false;

  List<Product> get items {
    if (_showFavoritesOnly) {
      return _items.where((prodItem) => prodItem.isFavorite).toList();
    }
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future<void> fetchAndSetProduct([bool filterByUser = false]) async {
    userId = cuerrentUser.uid;
    final filterString =
        filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
    var url =
        'https://ertizekil-bmg4-default-rtdb.firebaseio.com/Product.json?$filterString';
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      url =
          'https://ertizekil-bmg4-default-rtdb.firebaseio.com/userFavorites/$userId.json';
      final favoriteResponse = await http.get(Uri.parse(url));
      final favoriteData = json.decode(favoriteResponse.body);
      final List<Product> loadedProducts = [];
      extractedData.forEach((productId, productData) {
        loadedProducts.add(
          Product(
            id: productId,
            title: productData['title'],
            description: productData['description'],
            imageUrl: productData['image'],
            price: productData['price'],
            isFavorite:
                favoriteData == null ? false : favoriteData[productId] ?? false,
          ),
        );
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addProduct(Product product) async {
    const url =
        'https://ertizekil-bmg4-default-rtdb.firebaseio.com/Product.json';
    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'image': product.imageUrl,
            'price': product.price,
            'creatorId': userId,
          }));
      final newProduct = Product(
        title: product.title,
        description: product.description,
        imageUrl: product.imageUrl,
        price: product.price,
        id: json.decode(response.body)['name'],
      );
      _items.add(newProduct);
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodxtIndex = _items.indexWhere((element) => element.id == id);
    final url =
        'https://ertizekil-bmg4-default-rtdb.firebaseio.com/Product/$id.json';

    await http.patch(Uri.parse(url), body: {
      'title': newProduct.title,
      'description': newProduct.description,
      'image': newProduct.imageUrl,
      'price': newProduct.price,
    });

    if (prodxtIndex >= 0) {
      _items[prodxtIndex] = newProduct;
    } else {
      print('...');
    }
    notifyListeners();
  }

  void deleteProduct(String id) async {
    // upload to github.
    final url =
        'https://ertizekil-bmg4-default-rtdb.firebaseio.com/Product/$id.json';
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    var existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(Uri.parse(url));
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
    }
    existingProduct = null;
  }

  void getchatlist(String userid) async {
    userId = cuerrentUser.uid;
    final url =
        'https://ertizekil-bmg4-default-rtdb.firebaseio.com/chats/$userid.json';

    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      } else {
        extractedData.forEach((chatid, chatdata) {
          chatList.add(
            Chats(
              id: chatid,
              message: chatdata["message"],
              reciver: chatdata["reciver"],
              userid: userid,
            ),
          );
        });
      }
    } catch (err) {
      print(err);
    }
  }
}
