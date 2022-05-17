import 'package:email_auth/email_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:panacea/screens/sign_up_options.dart';


class CreateAccount extends StatefulWidget {
  static const String id = 'create-account';

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {

  final _formKey = GlobalKey<FormState>();
  Icon? icon;
  bool _visible = false;
  var _emailTextController = TextEditingController();
  final  TextEditingController _otpcontroller = TextEditingController();
  String? email;
  String? password;
  bool submitValid = false;
  late EmailAuth emailAuth;

  @override
  void initState() {
    super.initState();
    // Initialize the package
    emailAuth = new EmailAuth(
      sessionName: "PANACEA",
    );
  }

  void sendOTP() async {
    bool result = await emailAuth.sendOtp(
        recipientMail: _emailTextController.value.text, otpLength: 5);
    if (result) {
      // using a void function because i am using a
      // stateful widget and seting the state from here.
      setState(() {
        submitValid = true;
      });
    }
  }
 void verifyOTP() async{
   bool result = await emailAuth.validateOtp(
       recipientMail: _emailTextController.value.text,
       userOtp: _otpcontroller.value.text);
   if (result) {
     // using a void function because i am using a
     // stateful widget and seting the state from here.
     print('Email Verified');
   }
 }
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset : false,
      body: Form(
        key: _formKey,
        child: Padding(
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
                      Navigator.pushNamed(context, SignUpOptions.id);
                    },
                        icon: Icon(CupertinoIcons.arrow_left, color: Colors.black,)),
                    SizedBox(width: 30,),
                    Center(child: Text('Create account',
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                      // Text('Sign In')
                    ),

                  ],
                ),
              ),
              SizedBox(height: 80,),
              Container(
                child: TextFormField(
                  cursorColor: Colors.black,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  controller: _emailTextController,
                  validator: (value) {
                    if(value!.isEmpty){
                      return 'Please enter Email';
                    }
                    final bool _isValid = EmailValidator.validate(
                        _emailTextController.text
                    );
                    if(!_isValid){
                      return 'Invalid email format';
                    }
                    setState(() {
                      email = value;
                    });
                    return null;
                  },
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    contentPadding: EdgeInsets.zero,
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.black,),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.black,
                          width: 2
                      ),
                    ),
                    focusColor: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: 80,
              ),
              TextField(
                controller: _otpcontroller,
                keyboardType: TextInputType.number,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Enter OTP',
                  labelText: 'OTP'
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: TextButton(onPressed: () => sendOTP(),
                  child: Text('Send OTP'),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: TextButton(onPressed: () => verifyOTP(),
                  child: Text('Send OTP'),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text('OR', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
              SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: () {},
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 50),
                      child: Container(
                        child: Image.asset('images/google_icon.png'),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Center(child: Text('Sign in with Google')),
                  ],
                ),
              ),
              SizedBox(height: 130,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Not having Account?'),
                  TextButton(onPressed: (){},
                      child: Text('Sign Up Now'))
                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}
