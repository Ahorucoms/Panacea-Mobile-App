import 'package:flutter/material.dart';
import 'package:panacea/screens/sign_in_options.dart';
import 'package:panacea/widgets/app_large_text.dart';
import 'package:panacea/widgets/app_text.dart';

class SplashScreen extends StatelessWidget {
 static const String id = 'splash-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 54),
              child:
              Center(child: AppLargeText(text: 'PANACEA',)),
            ),
            SizedBox(height: 60,),
            Container(
              child: Center(child: AppText(text: 'Anonymous access to\n Healthcare services',)),
            ),
            SizedBox(height: 70,),
            Center(
              child: TextButton(
                  onPressed: (){
                    Navigator.pushNamed(context, SignInOptions.id);
                  },
                  child: Text('Get Started'),),
            ),
            SizedBox(height: 20,),
            Center(
              child: Image.asset('images/doctor.png',
              height: 250,),
            ),
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
      )
    );
  }
}
