import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:panacea/screens/sign_in_options.dart';
import 'package:panacea/widgets/app_large_text.dart';

class SignInWithPhoneNumber extends StatefulWidget {

  static const String id = 'sign-in-with-phone-numberr';

  @override
  State<SignInWithPhoneNumber> createState() => _SignInWithPhoneNumberState();
}

class _SignInWithPhoneNumberState extends State<SignInWithPhoneNumber> {

  bool _validPhoneNumber = false;
  var _phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                      SizedBox(width: 60,),
                      Center(child: AppLargeText(text: 'Sign In',)
                        // Text('Sign In')
                      ),

                    ],
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                Container(
                  child: TextField(
                    cursorColor: Colors.black,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    autofocus: true,
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    controller: _phoneNumberController,
                    onChanged: (value){
                      if(value.length == 10){
                        setState(() {
                          _validPhoneNumber = true;
                        });
                      }else{
                        setState(() {
                          _validPhoneNumber = false;
                        });
                      }
                    },

                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      contentPadding: EdgeInsets.zero,
                      labelText: 'Mobile number',
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
               Row(
                 children: [
                   AbsorbPointer(
                     absorbing: _validPhoneNumber ? false:true,
                     child: TextButton(onPressed: (){
                       setState(() {

                       });
                       String number = '${_phoneNumberController.text}';
                     },
                         child: Text('Authenticate')),
                   )
                   // Center(
                   //   child: TextButton(onPressed: (){},
                   //       child: Text('Authenticate')),
                   // ),
                 ],
               )

              ],
            ),
          ),

      ),
    );
  }
}
