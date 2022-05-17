import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:panacea/providers/auth_provider.dart';
import 'package:panacea/providers/location_provider.dart';
import 'package:panacea/screens/no/phone_password/sign-in-with-phone-number-and-password.dart';
import 'package:panacea/screens/no/phone_password/verify_phone_number.dart';
import 'package:panacea/screens/sign_in_options.dart';
import 'package:panacea/services/user_simple_preferences.dart';
import 'package:panacea/widgets/app_large_text.dart';
import 'package:international_phone_input/international_phone_input.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInWithPhoneNumber extends StatefulWidget {

  static const String id = 'sign-in-with-phone-number';

  @override
  State<SignInWithPhoneNumber> createState() => _SignInWithPhoneNumberState();
}

class _SignInWithPhoneNumberState extends State<SignInWithPhoneNumber> {

  FirebaseAuth auth = FirebaseAuth.instance;

  bool _validPhoneNumber = false;
  var _phoneNumberController = TextEditingController();
  String? _phone;

  void onPhoneNumberChange(String number, String internationalizedPhoneNumber, String isoCode) {
    setState(() {
      _phone = internationalizedPhoneNumber;
     print(_phone);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _phone = UserSimplePreferences.getNumber() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final locationData = Provider.of<LocationProvider>(context);
    return  SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset : false,
        body: Padding(
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
                        Navigator.pushNamed(context, SignInOptions.id);
                      },
                          icon: Icon(CupertinoIcons.arrow_left, color: Colors.black,)),
                      SizedBox(width: 20,),
                      Center(child: AppLargeText(text: 'Create account',)
                        // Text('Sign In')
                      ),

                    ],
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                        borderRadius: BorderRadius.circular(16.0)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InternationalPhoneInput(
                          decoration: InputDecoration.collapsed(hintText: 'Your phone number'),
                          onPhoneNumberChange: onPhoneNumberChange,
                          initialPhoneNumber: _phone,
                          initialSelection: 'RW',
                          // enabledCountries: ['+233', '+1'],
                          showCountryCodes: true,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                      TextButton(onPressed: () {
                        setState((){
                          auth.loading=true;
                          auth.screen = 'MapScreen';
                          auth.latitude = locationData.latitude;
                          auth.longitude=locationData.longitude;
                          auth.address = locationData.selectedAddress.addressLine;
                        });
                        String number ='${_phone}';
                        auth.verifyPhone(
                          context: context,
                          number: number,

                        ).then((value){
                          // setNumber(number);
                          UserSimplePreferences.setNumber(number);
                          setState(() {
                            auth.loading = false; //to disable circle indicator
                          });
                        });
                      },
                          child: Text('Sign up')),
                  ],
                ),
                SizedBox(height: 30,),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an Account?'),
                      TextButton(
                          onPressed: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context){
                              return SignInWithPhoneNumberAndPassword();
                            }));
                          },
                          child: Text('Login'),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30,),
                Center(child: Text('Or sign up with'),),
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Container(
                    height: 60,
                    width: 60,
                    child: IconButton(onPressed: (){},
                        icon: Image.asset('images/google_logo.png'),),
                  ),
                  SizedBox(width: 150,),
                  Container(
                    height: 60,
                    width: 60,
                    child: IconButton(onPressed: (){},
                        icon: Image.asset('images/facebook_icon.png'),
                    ),
                  )
                ],
                ),
                SizedBox(height: 40,),
                // Padding(
                //   padding: const EdgeInsets.only(bottom: 10),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       Text('Having Account?'),
                //       TextButton(onPressed: (){
                //         Navigator.pushNamed(context, SignInWithPhoneNumberAndPassword.id);
                //       },
                //           child: Text('Sign In Now'))
                //     ],
                //   ),
                // )
              ],
            ),
          ),
      ),
    );
  }
  Future<void> setNumber(String number) async{
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("number", number);
  }
}
