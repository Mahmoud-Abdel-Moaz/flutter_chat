import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = TextEditingController();
  String _enteredMessage = "";

  _sendMessage() async {
    FocusScope.of(context).unfocus();
    final user= FirebaseAuth.instance.currentUser;
    final userData=await FirebaseFirestore.instance.collection("Users").doc(user.uid).get();
    // Send Message hear
    FirebaseFirestore.instance
        .collection("Chat")
        .add({
      'message': _enteredMessage,
      'createAt': Timestamp.now(),
      'username':userData['username'],
      'userId':user.uid,
      'user_image':userData['image_url'],
        });
    setState(() {
      _enteredMessage="";
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
              child: TextField(
                style: TextStyle(color: Colors.white),
                cursorColor: Theme.of(context).primaryColor,
                autocorrect: true,
                enableSuggestions: true,
                textCapitalization: TextCapitalization.sentences,

                controller: _controller,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              ),
                hintText: "Send a message...",
              hintStyle: TextStyle(color: Theme.of(context).primaryColor),
            ),
            onChanged: (val) {
              setState(() {
                _enteredMessage = val;
              });
            },
          )),
          IconButton(
            color: Theme.of(context).primaryColor,
              disabledColor: Colors.white,
              onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
              icon: Icon(Icons.send))
        ],
      ),
    );
  }
}
