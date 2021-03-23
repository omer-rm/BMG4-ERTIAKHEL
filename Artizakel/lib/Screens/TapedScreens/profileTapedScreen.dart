import 'package:flutter/material.dart';

class ProfileTapedScreen extends StatefulWidget {
  @override
  _ProfileTapedScreenState createState() => _ProfileTapedScreenState();
}

class _ProfileTapedScreenState extends State<ProfileTapedScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Icon(
            Icons.account_circle,
            size: 150,
            color: Colors.grey,
          ),
          Text(
            "asya ahmed",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          Text(
            "firat mahallesi_Malatya_turkiye",
            style: TextStyle(fontSize: 15, color: Colors.black54),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  icon: Icon(
                    Icons.favorite,
                    size: 35,
                    color: Colors.red,
                  ),
                  onPressed: () {}),
              RaisedButton(
                onPressed: () {},
                child: Text(
                  "sign out",
                  style: TextStyle(fontSize: 20, color: Colors.blue),
                ),
              ),
            ],
          ),
          Divider(),
          myProducts(
              "https://images.unsplash.com/photo-1523275335684-37898b6baf30?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=689&q=80",
              "https://images.unsplash.com/photo-1491553895911-0055eca6402d?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=500&q=80"),
        ],
      ),
    );
  }

  Widget myProducts(String image1, String image2) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          theProduct(image1),
          theProduct(image2),
        ],
      ),
    );
  }

  Widget theProduct(String imageURL) {
    return Container(
      height: 100,
      width: 100,
      child: Image(
        image: NetworkImage(imageURL),
      ),
    );
  }
}
