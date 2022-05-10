// import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:panacea/providers/location_provider.dart';
import 'package:panacea/screens/home-screen.dart';
import 'package:panacea/screens/no/phone_password/sign-in-with-phone-number-and-password.dart';
import 'package:panacea/screens/no/phone_password/sign-in-with-phone-number.dart';
import 'package:panacea/screens/no/phone_password/yes_create_password.dart';
import 'package:panacea/screens/onboarding_screen.dart';
import 'package:panacea/services/user_services.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? smsOtp;
  String? verificationId;
  String error = '';
  UserServices _userServices = UserServices();
  bool loading = false;
  LocationProvider locationData = LocationProvider();
  String? screen;
  final _formKey = GlobalKey<FormState>();
  Icon? icon;
  String? email;
  String? password = null;
  String? pin;
  double? latitude;
  double? longitude;
  String? address;
  String? location;
   String number='';
  DocumentSnapshot? snapshot;

  CollectionReference _users = FirebaseFirestore.instance.collection('users');




  Future<void> verifyPhone({BuildContext? context, String? number}) async {
    this.loading = true;
    notifyListeners();

    final PhoneVerificationCompleted verificationCompleted = (PhoneAuthCredential credential) async {
      this.loading = false;
      notifyListeners();
      await _auth.signInWithCredential(credential);
    };

    final PhoneVerificationFailed verificationFailed = (FirebaseAuthException e) {
      this.loading = false;
      print(e.code);
      this.error = e.toString();
      notifyListeners();
    };

    final PhoneCodeSent smsOtpSend = (String? verId, [int? resendToken]) async {
      this.verificationId = verId;
      //Open the dialog box to enter the received SMS OTP
      smsOtpDialog(context!, number!);
    };

    try {
      _auth.verifyPhoneNumber(
        phoneNumber: number!,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: smsOtpSend,
        codeAutoRetrievalTimeout: (String verId) {
          this.verificationId = verId;
        },
      );
    } catch (e) {
      this.error = e.toString();
      this.loading = false;
      notifyListeners();
      print(e);
    }
  }

  Future smsOtpDialog(BuildContext context, String number) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              resizeToAvoidBottomInset : false,
              body: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: Row(
                          children: [
                            IconButton(onPressed: (){
                              Navigator.pushNamed(context, SignInWithPhoneNumber.id);
                            },
                                icon: Icon(CupertinoIcons.arrow_left, color: Colors.black,)),
                            SizedBox(width: 1,),
                            Center(child: Text('Confirm your email address',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                              // Text('Sign In')
                            ),

                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        child: Center(child: Text('Enter the 6 digit code we sent you\n via email to continue')),
                      ),
                      SizedBox(height: 60,),
                      PinEntryTextField(
                        showFieldAsBox: true,
                        onSubmit: (String pin) async{
                          this.smsOtp = pin;
                          try {
                            PhoneAuthCredential phoneAuthCredential =
                            PhoneAuthProvider.credential(verificationId: verificationId!, smsCode: smsOtp!);

                            final User? user = (await _auth.signInWithCredential(phoneAuthCredential)).user;

                            if (user != null) {
                              this.loading = false;
                              notifyListeners();

                              _userServices.getUserById(user.uid).then((snapShot) {

                                if (snapShot.exists) {

                                  //User data already exists
                                  if (this.screen == 'Login') {
                                    if ((snapShot.data() as Map)['address'] != null) {
                                      Navigator.pushReplacementNamed(context, HomeScreen.id);
                                    }
                                    Navigator.pushReplacementNamed(context, OnBoardingScreen.id);
                                  } else {

                                    //Need to update new selected address
                                    updateUser(id: user.uid, number: user.phoneNumber);
                                    Navigator.pushReplacementNamed(context, YesCreatePassword.id);
                                  }
                                } else {
                                  _createUser(id: user.uid, number: user.phoneNumber);
                                  // getPhone(user.phoneNumber);
                                  // Navigator.pushReplacementNamed(context, YesCreatePassword.id);
                                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                                    return YesCreatePassword(user.uid);
                                  }));
                                }
                              });
                            } else {
                              print('Login failed');
                            }
                          } catch (e) {
                            this.error = 'Invalid OTP';
                            notifyListeners();
                            print(e.toString());
                            Navigator.of(context).pop();
                          }
                        },
                      ),
                      SizedBox(height: 30,),

                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: TextButton(onPressed: (){
                          // Navigator.pushNamed(context, ConfirmedEmail.id);
                        },
                          child: Text('Resend code'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }).whenComplete(() {
      this.loading = false;
      notifyListeners();
    });
  }

  //-------------------Save Password data to Firestore-----------------
  // Future<void>? savePasswordToDb({ String? password, context}) {
  //   User? user = FirebaseAuth.instance.currentUser;
  //   _users.doc(this.number).update({
  //     'id': user!.uid,
  //     'password' : password,
  //   }).whenComplete(() {
  //     Navigator.pushReplacementNamed(context, HomeScreen.id);
  //   });
  //   return null;
  // }
  void savePasswordToDb({String? id,
    String? password,context}) {
    _userServices.updateUserData({
      'id': id,
      'password' : password,
    }).then((value) => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
      return SignInWithPhoneNumberAndPassword();
    })));
    this.loading = false;
    notifyListeners();

  }
//-------------------Save Delivery Boys data to Firestore-----------------

  void _createUser({String? id, String? number}) {
    _userServices.createUserData({
      'id': id,
      'number': number,
      'password' : this.password,
      'latitude': this.latitude,
      'longitude': this.longitude,
      'address': this.address,
      'location': this.location,
      'firstName' : ' ',
      'lastName' : ' '

    });
    this.loading = false;
    notifyListeners();
  }
  void login({String? phone, String? password}) {
    _userServices.Login({

      'number': phone,
      'password' : password,


    });
    this.loading = false;
    notifyListeners();
  }

  void updateUser({String? id,
    String? number}) {
    _userServices.updateUserData({
      'id': id,
      'number': number,
    });
    this.loading = false;
    notifyListeners();
  }

  getUserDetails()async {
    DocumentSnapshot result = await FirebaseFirestore.instance.collection('patients').doc(
        _auth.currentUser!.uid).get();
    if(result !=null){
      this.snapshot = result;
      notifyListeners();
    }else{
      this.snapshot = null;
      notifyListeners();
    }
    return result;
  }
}