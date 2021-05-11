import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble(
    this.message,
    this.userName,
    this.isMe, {
    this.key,
  });
  final String message;
  final bool isMe;
  final String userName;

  final Key key;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              width: 140,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              margin: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              decoration: BoxDecoration(
                color: isMe ? Colors.grey[300] : Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomLeft: !isMe ? Radius.circular(0) : Radius.circular(12),
                  bottomRight: isMe ? Radius.circular(0) : Radius.circular(12),
                ),
              ),
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                children: [
                  Text(
                    userName,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isMe
                            ? Colors.black
                            // ignore: deprecated_member_use
                            : Theme.of(context).accentTextTheme.title.color),
                  ),
                  Text(
                    message,
                    textAlign: isMe ? TextAlign.end : TextAlign.start,
                    style: TextStyle(
                        color: isMe
                            ? Colors.black
                            // ignore: deprecated_member_use
                            : Theme.of(context).accentTextTheme.title.color),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: -15,
          left: isMe ? null : 120,
          right: isMe ? 120 : null,
          child: CircleAvatar(
            child: Icon(Icons.account_circle),
          ),
        ),
      ],
      overflow: Overflow.visible,
    );
  }
}
