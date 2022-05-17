import 'package:flutter/material.dart';
import 'package:panacea/screens/no/email_password/sign-in-email.dart';
import 'package:panacea/screens/no/phone_password/sign-in-with-phone-number.dart';
import 'package:panacea/widgets/app_large_text.dart';
import 'package:panacea/widgets/app_text.dart';
import 'package:panacea/widgets/size_configs.dart';

import 'no/email_password/create_account.dart';

class MultipleSignUpOptions extends StatelessWidget {
  static const String id = 'multiple-sign-up-options';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(top: 54),
                  child:
                  Center(child: AppLargeText(text: 'PANACEA',)),
                ),
              ),
              SizedBox(height: 60,),
              Container(
                child: Center(child: AppText(text: 'Anonymous access to\n Healthcare services',)),
              ),
              SizedBox(height: 50,),
              Container(
                  child: Center(child: Text('PANACEA IS ANONYMOUS'))
              ),
              SizedBox(height: 20,),
              Container(
                child: TextButton(onPressed: (){},
                    child: Center(child: Text('Would you like to remain anonymous?'))),
              ),
              SizedBox(
                height: 20,
              ),
              Center(child: Text('You can also Sign Up with email or\n telephone number',
                textAlign: TextAlign.center,),
              ),
              SizedBox(
                height: 140,
              ),
              Container(
                child: Row(
                  children: [
                    TextButton(onPressed: (){
                      Navigator.pushNamed(context, CreateAccount.id);
                    },
                      child: Text('Sign Up with email'),),
                    SizedBox(width: SizeConfig.screenWidth! * .012,),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: TextButton(onPressed: (){
                        Navigator.pushNamed(context, SignInWithPhoneNumber.id);
                      },
                        child: Text('Telephone number'),),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
}
