import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:panacea/screens/no/confirm_email.dart';
import 'package:panacea/screens/no/create_password.dart';
import 'package:panacea/widgets/app_large_text.dart';

class ConfirmedEmail extends StatelessWidget {
  static const String id = 'confirmed-email';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                        Navigator.pushNamed(context, ConfirmEmail.id);
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
                  height: 80,
                ),
                Container(
                  child: Center(child: AppLargeText(text: 'Confirmed!'),
                  ),
                ),
                SizedBox(height: 80,),
                Container(
                  child: Center(child: Text('ahorucom@gmail.com is verified', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)),
                ),
                SizedBox(
                  height: 80,
                ),
                Center(
                  child: TextButton(onPressed: (){
                    Navigator.pushNamed(context, CreatePassword.id);
                  },
                    child: Text('Continue'),
                  ),
                ),
              ],
            ),
          ),
      ),
    );
  }
}
