import 'package:chatflash/screens/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class UsersScreen extends StatefulWidget {
  static String id = 'usersScressn';
  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  // List<Widget> usersWidgets = [];
  // getUsers() async {
  //   await for (var snapshot in _firestore.collection('users').snapshots()) {
  //     for (var doc in snapshot.docs) {
  //       setState(() {
  //         usersWidgets.add(
  //           // ignore: deprecated_member_use
  //           FlatButton(onPressed: () {}, child: Text(doc['username'])),
  //         );
  //       });
  //     }
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Friends'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                // messageStream();
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            StreamBuilder(
              stream: _firestore.collection('users').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Color(0xff125589),
                    ),
                  );
                }
                final users = snapshot.data.docs;
                List<MessageBubble> userWidgets = [];
                for (var user in users) {
                  final username = user['username'];
                  if (_auth.currentUser.email != username) {
                    final messageWidget = MessageBubble(
                      user: username,
                    );
                    userWidgets.add(messageWidget);
                  }
                }
                return Expanded(
                  child: ListView(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5,
                    ),
                    children: userWidgets,
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  MessageBubble({this.user});
  final String user;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            child: Material(
              borderRadius: BorderRadius.circular(50),
              color: Color(0xff125589),
              elevation: 5,
              child: FlatButton(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  padding: EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ChatScreen(
                        destination: user,
                      );
                    }));
                    print(user + _auth.currentUser.email);
                  },
                  child: Text(
                    user,
                    style: TextStyle(color: Colors.white),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
