import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:panacea/providers/auth_provider.dart';
import 'package:panacea/screens/no/phone_password/sign-in-with-phone-number.dart';
import 'package:provider/provider.dart';
import 'package:panacea/services/user_simple_preferences.dart';

class YesCreatePassword extends StatefulWidget {
 static const String id = 'yes-create-password';
 String user_id;
 YesCreatePassword(this.user_id);

  @override
  _YesCreatePasswordState createState() => _YesCreatePasswordState();
}

class _YesCreatePasswordState extends State<YesCreatePassword> {

  final _formKey = GlobalKey<FormState>();
  var _passwordTextController = TextEditingController();
  var _cPasswordTextController = TextEditingController();
  var _numberTextControler = TextEditingController();
  Icon? icon;
  bool _visible = false;
  String? password;
  String? confirmPassword;
  bool _isLoading = false;
  String? number;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      number=UserSimplePreferences.getNumber();
    });
    print(number);

  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    setState(() {
      _numberTextControler.text = auth.number;
      number = auth.number;
    });
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
                      SizedBox(width: 30,),
                      Center(child: Text('Create password',
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      ),

                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(height: 30,),
                Container(
                  child: TextFormField(
                    cursorColor: Colors.black,
                    style: TextStyle(color: Colors.black),
                    controller: _passwordTextController,
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Please Enter a Password';
                      }
                      if(value.length < 8){
                        return 'Password must be at least 8 characters';
                      }
                      setState(() {
                        password = value;
                      });
                      return null;
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
                        onPressed: (){
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
                        borderSide: BorderSide(
                            color: Colors.black,
                            width: 2
                        ),
                      ),
                      focusColor: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 30,),
                Container(
                  child: TextFormField(
                    cursorColor: Colors.black,
                    style: TextStyle(color: Colors.black),
                    controller: _cPasswordTextController,
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Please confirm password';
                      }
                      if(value.length < 8){
                        return 'Password must be at least 8 characters';
                      }
                      if(_passwordTextController.text != _cPasswordTextController.text){
                        return 'Confirmation password is not correct';
                      }
                      return null;
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
                        onPressed: (){
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
                      labelText: 'Confirm Password',
                      labelStyle: TextStyle(color: Colors.black),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black,
                            width: 2
                        ),
                      ),
                      focusColor: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: 70,
                ),
                Center(
                  child: TextButton(onPressed: () {
                   if(_formKey.currentState!.validate()){
                     User? user = FirebaseAuth.instance.currentUser;
                     // print(user!.uid);
                     if(user!.uid!=null){
                       auth.savePasswordToDb(
                         id: user.uid,
                         password: password,
                         context: context
                       );
                       // Navigator.pushReplacementNamed(context, SignInWithPhoneNumberAndPassword.id);
                     }else{
                       print('Password not created');
                     }
                   }

                  },
                    child: Text('Create password'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

