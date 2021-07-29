import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final Key key;
  final String message;
  final String userName;
  final String userImage;
  final bool isMe;


  MessageBubble(this.key, this.message, this.userName,this.userImage, this.isMe);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children:[
        Row(
          mainAxisAlignment: !isMe?MainAxisAlignment.end:MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: !isMe?  Colors.grey[300]:Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(14),
                  bottomRight: Radius.circular(14),
                  topLeft: isMe?Radius.circular(0):Radius.circular(14),
                  topRight: !isMe?Radius.circular(0):Radius.circular(14),
                ),
              ),
              width: 140,
              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 16),
              margin: EdgeInsets.symmetric(vertical: 15,horizontal: 45),
              child: Column(
                crossAxisAlignment:
                !isMe?CrossAxisAlignment.end:CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: !isMe
                          ? Colors.black
                          :Colors.white,
                      //:Theme.of(context).accentTextTheme.headline6.color,
                    ),
                  ),
                  Text(
                    message,
                    style: TextStyle(
                      color: !isMe
                          ? Colors.black
                          :Colors.white,
                    ),
                    textAlign: isMe?TextAlign.end:TextAlign.start,
                  ),
                ],
              ),
            )
          ],
        ),
        Positioned(
            top: -2,
            left: isMe?0:null,
            right: !isMe?0:null,
            child: CircleAvatar(
              backgroundImage: NetworkImage(userImage),
            )
        )
      ],
      overflow:  Overflow.visible,
    );
  }
}
