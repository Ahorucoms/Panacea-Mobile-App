import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:panacea/screens/yes/send_key_to_phonme_number.dart';
import 'package:panacea/widgets/app_large_text.dart';

class CreateWalletBlockChain extends StatelessWidget {
  const CreateWalletBlockChain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    Navigator.pushNamed(context, SendKeyToPhoneNumber.id);
                  },
                      icon: Icon(CupertinoIcons.arrow_left, color: Colors.black,)),
                  SizedBox(width: 20,),
                  Center(child: AppLargeText(text: 'Create Your wallet',)
                    // Text('Sign In')
                  ),

                ],
              ),
            ),
            SizedBox(
              height: 60,
            ),
            Row(
              children: [
                TextButton(onPressed: (){},
                    child: Row(
                      children: [
                        Text('Create Wallet'),
                        Icon(CupertinoIcons.forward),
                      ],
                    ))
              ],
            ),
            SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(onPressed: () {},
                    child: Text('Backup The Keys')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
