import 'package:Artizakel/Provider/ProviderHandler.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  DatabaseReference chatref =
      FirebaseDatabase.instance.reference().child("chats");
  String formatedString;
  @override
  Widget build(BuildContext context) {
    final chat = Provider.of<ProviderHandler>(context, listen: false);
    chat.getchatlist(chat.userId);
    return Scaffold(
        appBar: AppBar(
          title: Text("Chat page"),
        ),
        body: ListView.builder(
            itemCount: chat.chatList.length,
            itemBuilder: (context, i) {
              return new Column(
                children: [
                  new Divider(
                    height: 10,
                  ),
                  new ListTile(
                    leading: new CircleAvatar(
                      foregroundColor: Theme.of(context).primaryColor,
                      backgroundColor: Colors.grey,
                      backgroundImage: new NetworkImage(
                          'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg'),
                    ),
                    title: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: new Text(
                            chat.chatList[i].userid,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    subtitle: new Container(
                      padding: EdgeInsets.only(top: 5.0),
                      child: Text(
                        chat.chatList[i].message,
                        style: TextStyle(fontSize: 14.0, color: Colors.black54),
                      ),
                    ),
                  ),
                ],
              );
            }));
  }
}
