import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:wally/views/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'wally',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        backgroundColor: Color.fromARGB(247, 36, 36, 85),
        splash: Image.asset('assest/logo.gif'),
        nextScreen: Home(),
        splashIconSize: 900,
        splashTransition: SplashTransition.fadeTransition,
        duration: 3000,
      ),
    );
  }
}
