import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:panacea/screens/home-screen.dart';
import 'package:panacea/screens/onboarding_screen.dart';
import 'package:panacea/screens/yes/sign-in-with-phone-number-and-password.dart';
import 'package:panacea/services/user_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'splash-screen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    Timer(
        Duration(
          seconds: 3,
        ), () {
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user == null) {
          Navigator.pushReplacementNamed(context, OnBoardingScreen.id);
        } else {
          getUserData();
        }
      });
    });

    super.initState();
  }

  getUserData()async{
    UserServices _userServices = UserServices();
    _userServices.getUserById(user!.uid).then((result){
      if((result.data() as Map)['address']!=null){
        updatePrefs(result);
      }
      Navigator.pushReplacementNamed(context, SignInWithPhoneNumberAndPassword.id);
    });
  }

  Future<void>updatePrefs(result)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('latitude', result['latitude']);
    prefs.setDouble('longitude', result['longitude']);
    prefs.setString('address', result['address']);
    prefs.setString('location', result['location']);
    Navigator.pushReplacementNamed(context, HomeScreen.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('images/hands.png'),
            Text(
              'PANACEA',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}