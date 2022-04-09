import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const String id = 'home-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PANACEA HOME'),
      ),
      body: Center(
        child: Text('Congraturation it works !'),
      ),
    );
  }
}
