import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:panacea/screens/no/email_password/confirmed_email.dart';
import 'package:panacea/screens/sign_up_options.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';

class ConfirmEmail extends StatefulWidget {
  static const String id = 'confirm-email';

  @override
  State<ConfirmEmail> createState() => _ConfirmEmailState();
}

class _ConfirmEmailState extends State<ConfirmEmail> {

  final _formKey = GlobalKey<FormState>();
  Icon? icon;
  var _emailTextController = TextEditingController();
  var _pinTextController = TextEditingController();
  String? email;
  String? pin;

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
                  child: Center(child: Text('Enter the 4 digit code we sent you\n via email to continue')),
                ),
                SizedBox(height: 60,),
                PinEntryTextField(
                  showFieldAsBox: true,
                  onSubmit: (String pin){
                    showDialog(
                        context: context,
                        builder: (context){
                          return AlertDialog(
                            title: Text('Pin'),
                            content: Text('Pin entered is $pin'),
                          );
                        });
                  },
                ),
                SizedBox(height: 30,),

                SizedBox(
                  height: 20,
                ),
                Center(
                  child: TextButton(onPressed: (){
                    Navigator.pushNamed(context, ConfirmedEmail.id);
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
  }
}
