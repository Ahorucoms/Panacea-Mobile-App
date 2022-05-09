import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:panacea/screens/no/confirm_email.dart';
import 'package:panacea/screens/sign_in_options.dart';
import 'package:panacea/screens/sign_up_options.dart';
import 'package:panacea/widgets/app_large_text.dart';

class SignInEmail extends StatefulWidget {
  static const String id = 'sign-in-email';

  @override
  State<SignInEmail> createState() => _SignInEmailState();
}

class _SignInEmailState extends State<SignInEmail> {

  final _formKey = GlobalKey<FormState>();
  Icon? icon;
  bool _visible = false;
  var _emailTextController = TextEditingController();
  String? email;
  String? password;

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
                        SizedBox(width: 70,),
                       Center(child: Text('Log in',
                       style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                       textAlign: TextAlign.center,
                       ),
                       // Text('Sign In')
                       ),

                      ],
                    ),
                  ),
                  SizedBox(height: 50,),
                  Container(
                    child: TextFormField(
                      cursorColor: Colors.black,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      controller: _emailTextController,
                      validator: (value) {
                        if(value!.isEmpty){
                          return 'Please enter Email';
                        }
                        final bool _isValid = EmailValidator.validate(
                          _emailTextController.text
                        );
                        if(!_isValid){
                          return 'Invalid email format';
                        }
                        setState(() {
                          email = value;
                        });
                        return null;
                      },
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        contentPadding: EdgeInsets.zero,
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.black,),
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
                  SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: TextButton(onPressed: (){
                      Navigator.pushNamed(context, ConfirmEmail.id);
                    },
                        child: Text('Log In'),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('OR', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                  SizedBox(
                    height: 10,
                  ),
                TextButton(
                  onPressed: () {},
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 50),
                          child: Container(
                            child: Image.asset('images/google_icon.png'),
                          ),
                        ),
                        SizedBox(width: 10,),
                        Center(child: Text('Sign in with Google')),
                      ],
                    ),
                ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Not having Account?'),
                      TextButton(onPressed: (){
                        Navigator.pushNamed(context, SignInOptions.id);
                      },
                          child: Text('Sign Up Now'))
                    ],
                  )

                ],
              ),
            ),
          ),
        ),
    );
  }
}
