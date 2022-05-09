 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:panacea/screens/no/sign-in-email.dart';
import 'package:panacea/screens/sign_up_options.dart';

class CreatePassword extends StatefulWidget {
  static const String id = 'create-password';

  @override
  _CreatePasswordState createState() => _CreatePasswordState();
}

class _CreatePasswordState extends State<CreatePassword> {

  final _formKey = GlobalKey<FormState>();
  Icon? icon;
  bool _visible = false;
  String? password;
  String? confirmPassword;

  @override
  Widget build(BuildContext context) {
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
                        Navigator.pushNamed(context, SignUpOptions.id);
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
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Please Enter a Password';
                      }
                      if(value.length < 8){
                        return 'Password must be at least 8 characters';
                      }
                      setState(() {
                        confirmPassword = value;
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
                  child: TextButton(onPressed: (){
                    Navigator.pushNamed(context, SignInEmail.id);
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
