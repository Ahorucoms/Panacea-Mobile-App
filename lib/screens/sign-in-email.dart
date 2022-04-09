import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:panacea/screens/sign_in_options.dart';
import 'package:panacea/widgets/app_large_text.dart';
import 'package:panacea/widgets/app_text.dart';
import 'package:panacea/widgets/glassmorphism.dart';

class SignInEmail extends StatefulWidget {
  static const String id = 'sign-in-email';

  @override
  State<SignInEmail> createState() => _SignInEmailState();
}

class _SignInEmailState extends State<SignInEmail> {
  bool _isBlur = false;
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
                    Navigator.pushNamed(context, SignInOptions.id);
                  },
              icon: Icon(CupertinoIcons.arrow_left, color: Colors.black,)),
                        SizedBox(width: 60,),
                       Center(child: AppLargeText(text: 'Sign In',)
                       // Text('Sign In')
                       ),

                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    child: Center(child: Text('Anonymous access to\n Healthcare services')),
                  ),
                  SizedBox(height: 30,),
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
                    height: 20,
                  ),
                  Center(
                    child: TextButton(onPressed: (){},
                        child: Text('Sign In')),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(child: AppLargeText(text: 'OR')),
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
                    ),),
                  SizedBox(height: 5,),
                  Stack(
                    children: [
                      Center(
                        child: GestureDetector(
                          onTap: (){
                            setState(() {
                              _isBlur = !_isBlur;
                            });
                          },
                          child: GlassMorphism(
                            blur: _isBlur ? 20 : 0,
                            opacity: 0.2,
                            //we will change this later
                            child: const SizedBox(
                              height: 210,
                              width: 320,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  TextButton(
                      onPressed: (){},
                      child: Text('Not having Account?'))
                ],
              ),
            ),
          ),
        ),
    );
  }
}
