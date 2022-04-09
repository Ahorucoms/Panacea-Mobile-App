import 'package:flutter/material.dart';
import 'package:panacea/screens/fingerprint.dart';
import 'package:panacea/screens/home-screen.dart';
import 'package:panacea/screens/sign-in-email.dart';
import 'package:panacea/screens/sign-in-with-phone-number.dart';
import 'package:panacea/screens/sign_in_options.dart';
import 'package:panacea/screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PANACEA',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id:(context) =>SplashScreen(),
        SignInOptions.id:(context) =>SignInOptions(),
        SignInEmail.id:(context) => SignInEmail(),
        SignInWithPhoneNumber.id:(context)=> SignInWithPhoneNumber(),
        Fingerprint.id:(context)=> Fingerprint(),
        HomeScreen.id:(context)=> HomeScreen(),
      },
    );
  }
}