import 'package:Artizakel/Models/product.dart';
import 'package:Artizakel/Provider/ProviderHandler.dart';
import 'package:Artizakel/chats/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final authData = Provider.of<ProviderHandler>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            // Navigator.of(context).pushNamed(
            //   ProductsDetailScreen.routeName,
            //   arguments: product.id,
            // );
          },
          child: Hero(
            tag: product.id,
            child: FadeInImage(
              placeholder: AssetImage(""),
              image: NetworkImage(product.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(
            builder: (ctx, product, _) => IconButton(
              icon: Icon(
                product.isFavorite ? Icons.favorite : Icons.favorite_border,
              ),
              color: Colors.red,
              onPressed: () {
                product.toggleFavorateState(authData.userId);
              },
            ),
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.send,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Chatscreen(product.id),
              ));
            },
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
