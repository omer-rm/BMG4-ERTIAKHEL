import 'dart:convert';

import 'package:Artizakel/chats/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Messages extends StatefulWidget {
  Messages(this.productId);
  final String productId;

  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  var url = 'https://artizakhen.firebaseio.com/products.json';
  String resId;
  String userId;

  void getReseverId() async {
    var user = FirebaseAuth.instance;
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      extractedData.forEach((key, value) {
        if (key == widget.productId) {
          resId = value["creatorId"];
          userId = user.currentUser.uid;
        }
      });
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    getReseverId();
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .where('resiverId', isEqualTo: resId)
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (chatSnapshot.data == null) {
          return Center(child: CircularProgressIndicator());
        }
        final chatDocs = chatSnapshot.data.documents;
        return ListView.builder(
          reverse: true,
          itemCount: chatDocs.length,
          itemBuilder: (context, index) => MessageBubble(
            chatDocs[index]['text'],
            chatDocs[index]['userName'][0].toString(),
            chatDocs[index]['userId'] == FirebaseAuth.instance.currentUser.uid,
            key: ValueKey(
              chatDocs[index].documentID,
            ),
          ),
        );
      },
    );
  }
}
