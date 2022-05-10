import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:panacea/pages/favorite_page.dart';
import 'package:panacea/pages/home_page.dart';
import 'package:panacea/pages/profile_page.dart';
import 'package:panacea/pages/search_page.dart';
import 'package:panacea/pages/settings_page.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home-screen';
  String uid;
   HomeScreen({required this.uid});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  int index = 2;

  final screens = [
    HomePage(),
    SearchPage(),
    FavouritePage(),
    SettingsPage(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      Icon(Icons.home, size: 30,),
      Icon(Icons.search, size: 30,),
      Icon(Icons.favorite, size: 30,),
      Icon(Icons.settings, size: 30,),
      Icon(Icons.person, size: 30,),
    ];
    return Container(
      color: Colors.blue,
      child: SafeArea(
        top: false,
        child: ClipRect(
          child: Scaffold(
            extendBody: true,
            backgroundColor: Colors.white,
            // appBar: AppBar(
            //   title: Text('PANACEA HOME'),
            //   elevation: 0,
            //   centerTitle: true,
            // ),
            body: screens[index],
            bottomNavigationBar: Theme(
              data: Theme.of(context).copyWith(
                iconTheme: IconThemeData(color: Colors.black),
              ),
              child: CurvedNavigationBar(
                key: navigationKey,
                color: Color(0xffDBDAF2),
                buttonBackgroundColor: Color(0xffE4E3F0),
                backgroundColor: Colors.transparent,
                height: 60,
                  animationCurve: Curves.easeInOut,
                  animationDuration: Duration(milliseconds: 300),
                  index: index,
                  items: items,
                onTap: (index) => setState(() => this.index = index),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
