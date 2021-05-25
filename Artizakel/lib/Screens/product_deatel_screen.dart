import 'package:Artizakel/Provider/ProviderHandler.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final productId =
        ModalRoute.of(context).settings.arguments as String; // is the id!
    final loadedProduct = Provider.of<ProviderHandler>(
      context,
      listen: false,
    ).findById(productId);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: loadedProduct.id,
                child: Image.network(
                  loadedProduct.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                ),
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            FittedBox(
                              child: Text(
                                loadedProduct.title,
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              '\$${loadedProduct.price}',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 5),
                          child: Text(
                            loadedProduct.description,
                            softWrap: true,
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            "adress",
                            softWrap: true,
                            style: TextStyle(fontSize: 22),
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            "+999999999",
                            softWrap: true,
                            style: TextStyle(fontSize: 22),
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  InkWell(
                                    child: Text(
                                      "name",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        child: Icon(
                                          Icons.star_border,
                                          size: 27,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {},
                                        child: Icon(
                                          Icons.star_border,
                                          size: 27,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {},
                                        child: Icon(
                                          Icons.star_border,
                                          size: 27,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {},
                                        child: Icon(
                                          Icons.star_border,
                                          size: 27,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {},
                                        child: Icon(
                                          Icons.star_border,
                                          size: 27,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              // ignore: deprecated_member_use
                              RaisedButton(
                                elevation: 2,
                                color: Colors.brown,
                                onPressed: () {},
                                child: Text(
                                  "call the seller",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 24),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 500,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
