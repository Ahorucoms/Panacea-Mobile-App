import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:panacea/screens/multiple_sign_up_options.dart';
import 'package:panacea/screens/yes/backup_keys.dart';
import 'package:panacea/widgets/app_large_text.dart';

import 'no/phone_password/sign-in-with-phone-number.dart';

class SignUpOptions extends StatelessWidget {
 static const String id = 'sign-up-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xffE8EAEF),
            Color(0xffE8E7EE),
            Color(0xffE8EAEF),

          ])
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 54),
                child:
                Center(child: AppLargeText(text: 'PANACEA',)),
              ),
              SizedBox(height: 130,),
              Container(
                child: Center(child: Text('PANACEA IS ANNYMOUS',
                  style: TextStyle(fontStyle: FontStyle.italic,fontWeight: FontWeight.bold, fontSize: 16,),)),
              ),
              SizedBox(height: 80,),
              Container(
                child: Center(child: Text('Would you like to remain anonymous?',
                  style: TextStyle(fontStyle: FontStyle.italic,fontWeight: FontWeight.bold, fontSize: 16,),)),
              ),
             SizedBox(height: 100,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                  TextButton(
                    onPressed: (){
                      Navigator.pushNamed(context, BackupKeys.id);
                    },
                      child: Center(child: Text('YES', textAlign: TextAlign.center,)),
                  ),
                SizedBox(width: 20,),
                 TextButton(onPressed: (){
                   Navigator.pushNamed(context, SignInWithPhoneNumber.id);
                 },
                        child: Center(child: Text('NO'))),



              ],
            ),
            ],
          ),
        ),
      )
    );
  }
}
