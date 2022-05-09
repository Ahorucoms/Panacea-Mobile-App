import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: Text('Settings PAge',
          style: TextStyle(
            fontSize: 60,
            color: Colors.white,
          ),),
      ),
    );
  }
}
