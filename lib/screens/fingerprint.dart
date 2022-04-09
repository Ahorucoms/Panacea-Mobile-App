import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:panacea/screens/home-screen.dart';

class Fingerprint extends StatefulWidget {
 static const String id = 'fingerprint';

  @override
  _FingerprintState createState() => _FingerprintState();
}

class _FingerprintState extends State<Fingerprint> {

  final LocalAuthentication localAuthentication = LocalAuthentication();
  bool canAuth = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 14.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text('Welcome', style: TextStyle(
                  color: Colors.black,
                fontSize: 48.0,
                fontWeight: FontWeight.bold),),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 50.0),
                child: Column(
                  children: [
                    Image.asset('images/fingerprint.png',
                    width: 120.0,),
                    Text('Fingerprint Auth', style: TextStyle(
                      color: Colors.black,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 15.0),
                      width: 150.0,
                      child: Text('Authenticate using your fingerprint instead of your password',
                      textAlign: TextAlign.center,
                        style: TextStyle(
                        color: Colors.black,
                          height: 1.5,

                      ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 15.0),
                      width: double.infinity,
                      child: RaisedButton(
                        //Let's call our function
                          onPressed: () async{

                            List<BiometricType> list = [];
                            try{
                              if(canAuth){
                                list = await localAuthentication.getAvailableBiometrics();
                                if(list.length > 0){

                                  bool result = await localAuthentication.authenticateWithBiometrics(localizedReason: 'Please enter your fingerprint to unlock', useErrorDialogs: true,stickyAuth: false);

                                  print('Result is $result');
                                  if(list.contains(BiometricType.fingerprint)){
                                    print('Fingerprint');
                                  }
                                  if(list.contains(BiometricType.iris)){
                                    print('Iris');
                                  }
                                  if(list.contains(BiometricType.face)){
                                    print('Face Recognition');
                                  }
                                }
                              }
                            }catch(e){
                              print(e);
                            }
                          },
                      elevation: 0.0,
                        color: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 14.0,
                            horizontal: 24.0,
                          ),
                      child: Text('Authenticate', style: TextStyle(
                        color: Colors.white,
                      ),),),),
                    ),
                    SizedBox(height: 10,),
                    RaisedButton(onPressed: () async{
                      canAuth = await localAuthentication.canCheckBiometrics;
                      print(canAuth.toString());
                    })
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
