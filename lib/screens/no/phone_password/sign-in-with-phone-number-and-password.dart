import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:panacea/providers/auth_provider.dart';
import 'package:panacea/providers/location_provider.dart';
import 'package:panacea/screens/home-screen.dart';
import 'package:international_phone_input/international_phone_input.dart';
import 'package:panacea/widgets/size_configs.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInWithPhoneNumberAndPassword extends StatefulWidget {
  static const String id = 'sign-in-with-phone-number-and-password';

  @override
  _SignInWithPhoneNumberAndPasswordState createState() =>
      _SignInWithPhoneNumberAndPasswordState();
}

class _SignInWithPhoneNumberAndPasswordState
    extends State<SignInWithPhoneNumberAndPassword> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  var _passwordTextController = TextEditingController();
  Icon? icon;
  bool _visible = false;
  String password = '';
  String? confirmPassword;
  bool _isLoading = false;
  String? number;
  bool _validPhoneNumber = false;
  var _phoneNumberController = TextEditingController();
  String? _phone;

  void onPhoneNumberChange(
      String number, String internationalizedPhoneNumber, String isoCode) {
    setState(() {
      _phone = internationalizedPhoneNumber;
      print(_phone);
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final locationData = Provider.of<LocationProvider>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              SizedBox(
                height: SizeConfig.screenHeight! * .075,
              ),
              Container(
                child: Center(
                    child: Text(
                  'Welcome back to PANACEA',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                )
                    // Text('Sign In')
                    ),
              ),
              SizedBox(
                height: SizeConfig.screenHeight! * .075,
              ),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(16.0)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InternationalPhoneInput(
                      decoration: InputDecoration.collapsed(
                          hintText: 'Your phone number'),
                      onPhoneNumberChange: onPhoneNumberChange,
                      initialPhoneNumber: _phone,
                      initialSelection: 'RW',
                      // enabledCountries: ['+233', '+1'],
                      showCountryCodes: true,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.screenHeight! * .025,
              ),
              Container(
                child: TextFormField(
                  cursorColor: Colors.black,
                  style: TextStyle(color: Colors.black),
                  controller: _passwordTextController,
                  validator: (value) {
                    setState(() {
                      password = value.toString();
                    });

                    if (value!.isEmpty) {
                      return 'Please Enter a Password';
                    }
                    if (value.length < 8) {
                      return 'Password must be at least 8 characters';
                    }

                    // return null;
                  },
                  obscureText: _visible == false ? true : false,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: _visible
                          ? Icon(
                              Icons.visibility,
                              color: Colors.black,
                            )
                          : Icon(
                              Icons.visibility_off,
                              color: Colors.black,
                            ),
                      onPressed: () {
                        setState(() {
                          _visible = !_visible;
                        });
                      },
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    contentPadding: EdgeInsets.zero,
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                    ),
                    focusColor: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.screenHeight! * .080,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () async {
                        setState(() {
                          _isLoading = true;
                        });
                        await FirebaseFirestore.instance
                            .collection('users')
                            .where('number', isEqualTo: "$_phone")
                            // .where('password',isEqualTo: password)
                            .get()
                            .then((value) async {
                          setState(() {
                            _isLoading = false;
                          });
                          print(_phoneNumberController.text);
                          // print(value.docs.first['password']);
                          if (value.size == 1) {
                            print(value.docs.first['password']);

                            if (value.docs.first['password'] ==
                                _passwordTextController.text) {
                              final prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setString("uid", value.docs[0].id);
                              prefs.setString("phone", "$_phone");

                              // print(value.docs.first['password']);
                              Navigator.pushAndRemoveUntil(context,
                                  MaterialPageRoute(builder: (context) {
                                return HomeScreen(uid: value.docs[0].id);
                              }), (_) => false);
                            } else {
                              // print
                              return showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: Text("Login Fail"),
                                  content: Text(
                                      "Entered Information don't match ours"),
                                  actions: <Widget>[
                                    FlatButton(
                                      onPressed: () {
                                        setState(() {
                                          // isLoading = false;
                                        });
                                        Navigator.of(ctx).pop();
                                      },
                                      child: Text("close"),
                                    ),
                                  ],
                                ),
                              );
                            }
                          } else {
                            return showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: Text("Login Fail"),
                                content: Text(
                                    "Entered Information don't match ours"),
                                actions: <Widget>[
                                  FlatButton(
                                    onPressed: () {
                                      setState(() {
                                        // isLoading = false;
                                      });
                                      Navigator.of(ctx).pop();
                                    },
                                    child: Text("close"),
                                  ),
                                ],
                              ),
                            );
                          }
                        });
                        // print("this is resulr ${result}");
                        // auth.login(phone: "+250780640237",password: "12345678");
                        // if(_phone == ""){
                        //   setState(() {
                        //     print('Your phone number could not be validated');
                        //   });
                        // }
                      },
                      child: _isLoading
                          ? CircularProgressIndicator()
                          : Text('Log in')),
                ],
              ),
              SizedBox(
                height: SizeConfig.screenHeight! * .120,
              ),
              TextButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Forgot password?'),
                    Icon(CupertinoIcons.forward),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
