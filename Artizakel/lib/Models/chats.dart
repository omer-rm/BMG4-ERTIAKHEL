import 'package:flutter/cupertino.dart';

class Chats with ChangeNotifier {
  String userid;
  String message;
  String id;
  String reciver;

  Chats({this.id, this.message, this.reciver, this.userid});
}
