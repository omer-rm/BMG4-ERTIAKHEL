import 'package:Artizakel/Provider/ProviderHandler.dart';
import 'package:Artizakel/Screens/FavoritesScreen.dart';
import 'package:Artizakel/Screens/HomePageScreen.dart';
import 'package:Artizakel/Screens/product_deatel_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

DatabaseReference userRef =
    FirebaseDatabase.instance.reference().child("users");
DatabaseReference productRef =
    FirebaseDatabase.instance.reference().child("Product");

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProviderHandler(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Artizakhl',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomeScreen(),
        routes: {
          ProductsDetailScreen.routeName: (context) => ProductsDetailScreen(),
          FavoritesScreen.routeName: (context) => FavoritesScreen(),
        },
      ),
    );
  }
}
