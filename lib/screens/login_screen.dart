import 'package:chatflash/screens/chat_screen.dart';
import 'package:chatflash/screens/usersScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chatflash/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'loginScreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  Constants constant = Constants();
  //
  // AnimationController controller;
  // Animation animation;
  //
  // @override
  // void initState() {
  //   super.initState();
  //
  //   controller = AnimationController(
  //     duration: Duration(seconds: 1),
  //     vsync: this,
  //   );
  //   // animation =
  //   //     ColorTween(begin: Colors.grey, end: Colors.white).animate(controller);
  //
  //   controller.reverse(from: 1.0);
  //   // controller.reverse(from: 1.0);
  //
  //   controller.addListener(() {
  //     setState(() {});
  //     // print(controller.value);
  //   });
  // }

  final _auth = FirebaseAuth.instance;
  String email;
  String password;

  bool showSpanner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpanner,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: 'logo',
                child: Container(
                  child: Image.asset('images/logo.png'),
                  height: 150,
                  // controller.value * 200 > 100 ? controller.value * 200 : 100,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color: Color(0xff125589).withOpacity(0.5),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: TextField(
                    onChanged: (value) {
                      email = value;
                    },
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: 'email address',
                      border: InputBorder.none,
                      isDense: true,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color: Color(0xff125589).withOpacity(0.5),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: TextField(
                    onChanged: (value) {
                      password = value;
                    },
                    // keyboardType: KeyboardKey,
                    textAlign: TextAlign.center,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'password',
                      border: InputBorder.none,
                      isDense: true,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 150,
                decoration: constant.kBoxDecoration,
                // ignore: deprecated_member_use
                child: FlatButton(
                  color: Color(0xff125589),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    'Log In',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () async {
                    setState(() {
                      showSpanner = true;
                    });
                    try {
                      final user = await _auth.signInWithEmailAndPassword(
                          email: email, password: password);
                      if (user != null) {
                        Navigator.pushReplacementNamed(context, UsersScreen.id);
                      }
                      setState(() {
                        showSpanner = false;
                      });
                    } catch (e) {
                      setState(() {
                        showSpanner = false;
                      });
                      print(e);
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
