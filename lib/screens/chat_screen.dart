import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  static String id = "chatScreen";
  ChatScreen({this.destination});
  final String destination;
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  String messageText;
  var messages;
  final clearText = TextEditingController();
  void clearTxt() {
    clearText.clear();
  }

  // getCurrentUser() async {
  //   try {
  //     final user = _auth.currentUser;
  //     if (user != null) {
  //       print(user.email);
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // getMessages() {
  //   _firestore.collection('messages').get().then((QuerySnapshot querySnapshot) {
  //     messages = querySnapshot.docs;
  //   });
  //
  //   // messages.forEach((doc) {
  //   //   print(doc['text']);
  //   // });
  // }
  //
  // void messageStream() async {
  //   await for (var snapshot in _firestore.collection('messages').snapshots()) {
  //     for (var doc in snapshot.docs) {
  //       print(doc['text']);
  //     }
  //   }
  // }
  String destinationUser;
  @override
  void initState() {
    super.initState();
    // getCurrentUser();
    setState(() {});
    destinationUser = widget.destination;
    print(destinationUser);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.destination),
        backgroundColor: Color(0xff125589),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('messages')
                  .where('id', whereIn: [
                    _auth.currentUser.email + widget.destination,
                    widget.destination + _auth.currentUser.email
                  ])
                  .orderBy('time', descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Color(0xff125589),
                    ),
                  );
                }
                final messages = snapshot.data.docs.reversed;
                List<MessageBubble> messageWidgets = [];
                for (var message in messages) {
                  final messageText = message['text'];
                  final messageSender = message['sender'];

                  final messageWidget = MessageBubble(
                    message: messageText,
                    sender: messageSender,
                    isMe: _auth.currentUser.email == messageSender,
                  );
                  messageWidgets.add(messageWidget);
                }
                return Expanded(
                  child: ListView(
                    reverse: true,
                    padding: EdgeInsets.symmetric(
                      horizontal: 5,
                    ),
                    children: messageWidgets,
                  ),
                );
              },
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Color(0xff125589), width: 1.0),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: clearText,
                      onChanged: (value) {
                        //Do something with the user input.
                        messageText = value;
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        hintText: 'Type your message here...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  // ignore: deprecated_member_use
                  FlatButton(
                    onPressed: () {
                      if (messageText != '') {
                        _firestore.collection('messages').add({
                          'text': messageText,
                          'sender': _auth.currentUser.email,
                          'id': _auth.currentUser.email + widget.destination,
                          'time': DateTime.now()
                        });
                      }
                      clearTxt();
                      messageText = '';
                      //Implement send functionality.
                    },
                    child: Text(
                      'Send',
                      style: TextStyle(
                        color: Color(0xff125589),
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({this.message, this.sender, this.isMe});
  final String message;
  final String sender;
  final bool isMe;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12.0,
            ),
          ),
          Material(
            borderRadius: isMe
                ? BorderRadius.only(
                    bottomRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                  )
                : BorderRadius.only(
                    bottomRight: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                  ),
            elevation: 5.0,
            color: isMe ? Color(0xff125589) : Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                '$message',
                style: TextStyle(
                  color: isMe ? Colors.white : Colors.black,
                  fontSize: 15,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
