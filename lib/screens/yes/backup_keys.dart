import 'package:flutter/material.dart';
import 'package:panacea/screens/fingerprint.dart';
import 'package:panacea/screens/yes/send_key_to_email.dart';
import 'package:panacea/screens/yes/send_key_to_phonme_number.dart';
import 'package:panacea/widgets/app_large_text.dart';
import 'package:panacea/widgets/app_text.dart';

class BackupKeys extends StatelessWidget {
 static const String id = 'backup-keys';

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
                  child: Center(child: Text('Backup Your Keys'))
              ),
              SizedBox(height: 20,),
              Container(
                child: TextButton(onPressed: (){
                  Navigator.pushNamed(context, Fingerprint.id);
                },
                    child: Center(child:TextButton(onPressed: (){
                      Navigator.pushReplacementNamed(context, SendKeyToEmail.id);
                    },
                      child: Text('Send Keys To Your Email',
                        textAlign: TextAlign.center,),
                    ),
                    ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(child: TextButton(onPressed: (){
                Navigator.pushReplacementNamed(context, SendKeyToPhoneNumber.id);
              },
                child: Text('Send Keys To Your SMS',
                  textAlign: TextAlign.center,),
              ),
              ),
              SizedBox(
                height: 140,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(onPressed: (){},
                     child: Text('Backup Wallet',
                     textAlign: TextAlign.center,),
                    ),
                  ],
                ),
                ),
            ],
          ),
        )
    );
  }
}
