import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chatflash/screens/registration_screen.dart';
import 'package:chatflash/screens/login_screen.dart';
import 'package:chatflash/constants.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcomeScreen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  Constants constant = Constants();

  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: Duration(seconds: 1),
      upperBound: 1,
      vsync: this,
    );

    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);

    controller.forward();

    // animation.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     controller.reverse(from: 1.0);
    //   } else if (status == AnimationStatus.dismissed) {
    //     controller.forward();
    //   }
    // });

    controller.addListener(() {
      setState(() {});
    });
  }

  // @override
  // void dispose() {
  //   controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Hero(
                  tag: 'logo',
                  child: Container(
                    // child: Icon(
                    //   Icons.bolt,
                    //   size: animation.value * 100,
                    //   color: Color(0xffeca01e),
                    // ),
                    child: Image.asset('images/logo.png'),
                    height: 60, //animation.value * 100,
                  ),
                ),
                // Text(
                //   'Flash Chat',
                //   style: TextStyle(
                //     fontSize: 40.0,
                //     fontWeight: FontWeight.w900,
                //   ),
                // ),
                // ignore: deprecated_member_use
                TypewriterAnimatedTextKit(
                  speed: Duration(milliseconds: 200),
                  text: ['Flash Chat'],
                  textStyle: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            Container(
              height: 42,
              width: double.infinity,
              decoration: constant.kBoxDecoration,
              // ignore: deprecated_member_use
              child: FlatButton(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                color: Color(0xff125589),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  'Log In',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                },
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Container(
              height: 40,
              width: double.infinity,
              decoration: constant.kBoxDecoration,
              // ignore: deprecated_member_use
              child: FlatButton(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                color: Colors.white,
                child: Text('Register'),
                onPressed: () {
                  Navigator.pushNamed(context, RegisterScreen.id);
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  side: BorderSide(
                    color: Colors.grey,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
