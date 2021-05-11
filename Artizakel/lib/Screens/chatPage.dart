import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  String formatedString;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat page"),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('chats').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              print("No DATA FOUND");
              return CircularProgressIndicator();
            }
            var docs = snapshot.data.documents;
            print(docs.length);
            return ListView.builder(
                itemCount: docs.length,
                itemBuilder: (context, i) {
                  DateTime dateTime = docs[i]['createdAt'].toDate();
                  return Dismissible(
                    key: ValueKey(docs),
                    onDismissed: (covariant) {
                      setState(() {
                        docs.removeAt(i);
                      });
                    },
                    child: new Column(
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
                                  docs[i]['userName'][0].toString(),
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              new Text(
                                DateFormat().format(dateTime),
                                style: TextStyle(
                                    fontSize: 14.0, color: Colors.black54),
                              ),
                            ],
                          ),
                          subtitle: new Container(
                            padding: EdgeInsets.only(top: 5.0),
                            child: Text(
                              docs[i]['text'],
                              style: TextStyle(
                                  fontSize: 14.0, color: Colors.black54),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                });
          }),
    );
  }
}
