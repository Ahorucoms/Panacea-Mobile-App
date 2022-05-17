// @dart=2.9
import 'package:country_code_picker/country_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:panacea/providers/auth_provider.dart';
import 'package:panacea/providers/cart_provider.dart';
import 'package:panacea/providers/coupon_provider.dart';
import 'package:panacea/providers/location_provider.dart';
import 'package:panacea/providers/order_provider.dart';
import 'package:panacea/providers/store_provider.dart';
import 'package:panacea/screens/landing_screen.dart';
import 'package:panacea/screens/map_screen.dart';
import 'package:panacea/screens/multiple_sign_up_options.dart';
import 'package:panacea/screens/my_orders_screen.dart';
import 'package:panacea/screens/no/email_password/confirm_email.dart';
import 'package:panacea/screens/no/email_password/confirmed_email.dart';
import 'package:panacea/screens/no/email_password/create_account.dart';
import 'package:panacea/screens/no/email_password/create_password.dart';
import 'package:panacea/screens/home-screen.dart';
import 'package:panacea/screens/no/email_password/no_sign_in_with_phone_number.dart';
import 'package:panacea/screens/no/email_password/sign-in-email.dart';
import 'package:panacea/screens/no/phone_password/sign-in-with-phone-number-and-password.dart';
import 'package:panacea/screens/no/phone_password/sign-in-with-phone-number.dart';
import 'package:panacea/screens/no/phone_password/verify_phone_number.dart';
import 'package:panacea/screens/no/phone_password/yes_create_password.dart';
import 'package:panacea/screens/onboarding_screen.dart';
import 'package:panacea/screens/splash_screen.dart';
import 'package:panacea/screens/welcome_screen.dart';
import 'package:panacea/screens/yes/backup_keys.dart';
import 'package:panacea/screens/sign_in_options.dart';
import 'package:panacea/screens/sign_up_options.dart';
import 'package:panacea/screens/yes/send_key_to_email.dart';
import 'package:panacea/screens/yes/send_key_to_phonme_number.dart';
import 'package:panacea/services/user_simple_preferences.dart';
import 'package:provider/provider.dart';

void main() async {
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
        ChangeNotifierProvider(
          create: (_) => StoreProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CouponProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrderProvider(),
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
        Locale('en', 'US'),
      ],
      localizationsDelegates: [
        CountryLocalizations
            .delegate, // Use for all countries name show in english
      ],
      debugShowCheckedModeBanner: false,
      title: 'PANACEA',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => SplashScreen(),
        OnBoardingScreen.id: (context) => OnBoardingScreen(),
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LandingScreen.id : (context) => LandingScreen(),
        SignUpOptions.id: (context) => SignUpOptions(),
        SignInOptions.id: (context) => SignInOptions(),
        SignInWithPhoneNumberAndPassword.id: (context) => SignInWithPhoneNumberAndPassword(),
        SignInEmail.id: (context) => SignInEmail(),
        ConfirmEmail.id: (context) => ConfirmEmail(),
        ConfirmedEmail.id: (context) => ConfirmedEmail(),
        CreatePassword.id: (context) => CreatePassword(),
        CreateAccount.id: (context) => CreateAccount(),
        SignInWithPhoneNumber.id: (context) => SignInWithPhoneNumber(),
        MultipleSignUpOptions.id: (context) => MultipleSignUpOptions(),
        BackupKeys.id: (context) => BackupKeys(),
        SendKeyToPhoneNumber.id: (context) => SendKeyToPhoneNumber(),
        SendKeyToEmail.id: (context) => SendKeyToEmail(),
        VerifyPhoneNumber.id: (context) => VerifyPhoneNumber(),
        YesCreatePassword.id: (context) => YesCreatePassword(""),
        NoSignInWithPhoneNumber.id: (context) => NoSignInWithPhoneNumber(),
        MyOrders.id:(context)=>MyOrders(),
        HomeScreen.id: (context) => HomeScreen(),
      },
      builder: EasyLoading.init(),
    );
  }
}
