import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:international_phone_input/international_phone_input.dart';
import 'package:panacea/providers/auth_provider.dart';
import 'package:panacea/screens/yes/backup_keys.dart';
import 'package:panacea/widgets/app_large_text.dart';
import 'package:provider/provider.dart';

class SendKeyToPhoneNumber extends StatefulWidget {
  static const String id = 'send-key-to-phone-number';

  @override
  _SendKeyToPhoneNumberState createState() => _SendKeyToPhoneNumberState();
}

class _SendKeyToPhoneNumberState extends State<SendKeyToPhoneNumber> {
  FirebaseAuth auth = FirebaseAuth.instance;

  String? _phone;

  void onPhoneNumberChange(String number, String internationalizedPhoneNumber, String isoCode) {
    setState(() {
      _phone = internationalizedPhoneNumber;
      print(_phone);
    });
  }
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset : false,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            Container(
              child: Row(
                children: [
                  IconButton(onPressed: (){
                    Navigator.pushNamed(context, BackupKeys.id);
                  },
                      icon: Icon(CupertinoIcons.arrow_left, color: Colors.black,)),
                  SizedBox(width: 60,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Sign Up',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      textAlign: TextAlign.center,),
                    ],
                  ),

                ],
              ),
            ),
            SizedBox(
              height: 60,
            ),
            Center(
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(16.0)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InternationalPhoneInput(
                    decoration: InputDecoration.collapsed(hintText: 'Your Mobile Number'),
                    onPhoneNumberChange: onPhoneNumberChange,
                    initialPhoneNumber: _phone,
                    initialSelection: 'RW',
                    // enabledCountries: ['+233', '+1'],
                    showCountryCodes: true,
                  ),
                ),
              ),
            ),
            SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(onPressed: () {},
                    child: Text('Backup Keys')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
