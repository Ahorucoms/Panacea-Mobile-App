import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:panacea/providers/location_provider.dart';
import 'package:panacea/screens/home-screen.dart';
import 'package:panacea/screens/map_screen.dart';
import 'package:panacea/services/user_services.dart';

class LandingScreen extends StatefulWidget {
  static const String id = 'landing-screen';

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  LocationProvider _locationProvider = LocationProvider();
  bool _loading = false;
  UserServices _userServices = UserServices();
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {

    _userServices.getUserById(user!.uid).then((result){
      if((result.data() as Map)['latitude']!=null){
        Navigator.pushReplacementNamed(context, HomeScreen.id);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Delivery address has not been set ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Please update your delivery location to find the nearest stores for you',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ),

            Container(
              width: 600,
              child: Image.asset(
                'images/city.png',
                fit: BoxFit.fill,
                color: Colors.black12,
              ),
            ),
            _loading ? CircularProgressIndicator() : FlatButton(
              color: Theme.of(context).primaryColor,
              onPressed: () async{
                setState(() {
                  _loading = true;
                });

                await _locationProvider.getCurrentPosition();
                if (_locationProvider.permissionAllowed==true) {

                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (BuildContext context) => MapScreen()));
                } else {
                  Future.delayed(Duration(seconds: 4),(){
                    if (_locationProvider.permissionAllowed == false){
                      print('Access is not allowed');
                      setState(() {
                        _loading=false;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Please allow access to find the nearest store for you'),
                      ));
                    }
                  });
                }
              },
              child: Text(
                'Set your location',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}