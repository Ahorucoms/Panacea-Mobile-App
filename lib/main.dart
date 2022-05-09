// @dart=2.9
import 'package:country_code_picker/country_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:panacea/providers/auth_provider.dart';
import 'package:panacea/providers/location_provider.dart';
import 'package:panacea/screens/no/confirm_email.dart';
import 'package:panacea/screens/no/confirmed_email.dart';
import 'package:panacea/screens/no/create_account.dart';
import 'package:panacea/screens/no/create_password.dart';
import 'package:panacea/screens/fingerprint.dart';
import 'package:panacea/screens/home-screen.dart';
import 'package:panacea/screens/no/no_sign_in_with_phone_number.dart';
import 'package:panacea/screens/onboarding_screen.dart';
import 'package:panacea/screens/no/sign-in-email.dart';
import 'package:panacea/screens/splash_screen.dart';
import 'package:panacea/screens/yes/sign-in-with-phone-number.dart';
import 'package:panacea/screens/sign_in_options.dart';
import 'package:panacea/screens/sign_up_options.dart';
import 'package:panacea/screens/yes/verify_phone_number.dart';
import 'package:panacea/screens/yes/yes_create_password.dart';
import 'package:panacea/services/user_services.dart';
import 'package:panacea/services/user_simple_preferences.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await UserSimplePreferences.init();
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => AuthProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => LocationProvider(),
          ),
        ],
          child: MyApp(),
      ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      supportedLocales: [
        Locale('en','US'),
      ],
      localizationsDelegates: [
        CountryLocalizations.delegate,// Use for all countries name show in english
      ],

      debugShowCheckedModeBanner: false,
      title: 'PANACEA',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: OnBoardingScreen.id,
      routes: {
        OnBoardingScreen.id:(context) => OnBoardingScreen(),
        SignUpOptions.id:(context) =>SignUpOptions(),
        SignInOptions.id:(context) =>SignInOptions(),
        SignInEmail.id:(context) => SignInEmail(),
        ConfirmEmail.id:(context) => ConfirmEmail(),
        ConfirmedEmail.id:(context) => ConfirmedEmail(),
        CreatePassword.id:(context) => CreatePassword(),
        CreateAccount.id:(context) => CreateAccount(),
        SignInWithPhoneNumber.id:(context)=> SignInWithPhoneNumber(),
        VerifyPhoneNumber.id:(context) => VerifyPhoneNumber(),
        YesCreatePassword.id:(context) => YesCreatePassword(""),
        NoSignInWithPhoneNumber.id:(context) => NoSignInWithPhoneNumber(),
        Fingerprint.id:(context)=> Fingerprint(),
        HomeScreen.id:(context)=> HomeScreen(),
      },
    );
  }
}