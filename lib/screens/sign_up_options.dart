import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:panacea/screens/home-screen.dart';
import 'package:panacea/screens/no/create_account.dart';
import 'package:panacea/screens/no/no_sign_in_with_phone_number.dart';
import 'package:panacea/screens/no/sign-in-email.dart';
import 'package:panacea/screens/yes/sign-in-with-phone-number.dart';
import 'package:panacea/widgets/app_large_text.dart';

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
                      Navigator.pushNamed(context, SignInWithPhoneNumber.id);
                    },
                      child: Center(child: Text('YES', textAlign: TextAlign.center,)),
                  ),
                SizedBox(width: 20,),
                 TextButton(onPressed: (){
                   Navigator.pushNamed(context, NoSignInWithPhoneNumber.id);
                 },
                        child: Center(child: Text('NO'))),



              ],
            )
              // Container(
              //   height: 80,
              //   width: 80,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(20),
              //     color: Colors.white,
              //     image: DecorationImage(
              //       image: AssetImage(
              //           'images/person.png'
              //       ),
              //       fit: BoxFit.cover,
              //     )
              //   ),
              // )
            ],
          ),
        ),
      )
    );
  }
}
