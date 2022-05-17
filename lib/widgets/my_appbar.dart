import 'package:flutter/material.dart';
import 'package:panacea/constants.dart';
import 'package:panacea/providers/location_provider.dart';
import 'package:panacea/screens/map_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAppBar extends StatefulWidget {
  @override
  _MyAppBarState createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  String _location = '';
  String _address = '';

  @override
  void initState() {
    getPrefs();
    super.initState();
  }

  getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? location = prefs.getString('location');
    String? address = prefs.getString('address');
    setState(() {
      _location = location!;
      _address = address!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final locationData = Provider.of<LocationProvider>(context);
    return SliverAppBar(
      automaticallyImplyLeading: false,
      elevation: 0.0,
      floating: true,
      snap: true,
      title: FlatButton(
        onPressed: () {
          locationData.getCurrentPosition().then((value){
            if (value!=null) {
              pushNewScreenWithRouteSettings(
                context,
                settings: RouteSettings(name: MapScreen.id),
                screen: MapScreen(),
                withNavBar: false,
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );
            } else {
              print('Something went wrong');
            }
          });

        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Flexible(
                  child: Text(
                    _location == null ? 'Address not set' : _location,
                    style: TextStyle(color: kTextBlackColor,fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(
                  Icons.edit_outlined,
                  color: kTextBlackColor,
                  size: 15,
                ),
              ],
            ),
            Flexible(
                child: Text(
                  _address==null? 'Click here to set up a shipping address' : _address,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: kTextBlackColor,fontSize: 12),
                )),
          ],
        ),
      ),
    );
  }
}
