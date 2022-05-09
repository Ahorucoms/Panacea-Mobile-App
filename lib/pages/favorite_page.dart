import 'package:flutter/material.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: Text('Favourite',
          style: TextStyle(
            fontSize: 60,
            color: Colors.white,
          ),),
      ),
    );
  }
}
