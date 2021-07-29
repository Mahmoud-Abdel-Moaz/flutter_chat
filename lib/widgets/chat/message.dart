import 'package:chat_flutter/widgets/chat/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class Message extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("Chat").orderBy(
          'createAt', descending: true).snapshots(),
      builder: (ctx, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
        if (streamSnapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        final user = FirebaseAuth.instance.currentUser;
        final docs = streamSnapshot.data!.docs;
        return ListView.builder(
            reverse: true,
            itemCount: docs.length,
            itemBuilder: (ctx, index) {
            //  print(docs[index]['message']);
              return MessageBubble(
                    ValueKey(docs[index].id),
                    docs[index]['message'],
                    docs[index]['username'],
                    docs[index]['user_image'],
                    user.uid == docs[index]['userId']
                );
            }
          /*Container(
              padding: EdgeInsets.all(8),
              child: Text(docs[index]['message']),
            )*/
        );
      },
    );
  }

}