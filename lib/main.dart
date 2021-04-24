import 'package:flutter/material.dart';
import 'package:chatflash/screens/welcome_screen.dart';
import 'package:chatflash/screens/login_screen.dart';
import 'package:chatflash/screens/registration_screen.dart';
// import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chatflash/screens/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:chatflash/screens/usersScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flash Chat',
      theme: ThemeData().copyWith(
        primaryColor: Color(0xff125589),
      ),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegisterScreen.id: (context) => RegisterScreen(),
        ChatScreen.id: (context) => ChatScreen(),
        UsersScreen.id: (context) => UsersScreen()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
