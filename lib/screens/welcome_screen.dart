import 'package:flutter/material.dart';
import 'package:panacea/providers/auth_provider.dart';
import 'package:panacea/providers/location_provider.dart';
import 'package:panacea/screens/map_screen.dart';
import 'package:panacea/widgets/app_large_text.dart';
import 'package:panacea/widgets/app_text.dart';
import 'package:panacea/widgets/size_configs.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatefulWidget {
  final Key _mapKey = UniqueKey();
  static const String id = 'welcome-screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {

    final auth = Provider.of<AuthProvider>(context);

    final locationData = Provider.of<LocationProvider>(context,listen: false);

    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(top: 54),
                  child: Center(
                      child: AppLargeText(
                        text: 'PANACEA',
                      )),
                ),
              ),
              SizedBox(
                height: SizeConfig.screenHeight! * .150,
              ),
              Container(
                child: Center(
                    child: Text(
                      'Set Location to Set the Appointments from\n nearest Hospitals and Order Recommended \n Medics to your DoorStep',
                      textAlign: TextAlign.center,
                    )),
              ),
              SizedBox(
                height: SizeConfig.screenHeight! * .140,
              ),
              Container(child: Center(child: Text('Ready to order from your nearest Pharmacy?'))),
              SizedBox(
                height: 80,
              ),
              SizedBox(
                height: SizeConfig.screenHeight! * .075,
              ),
              Center(
                child: Container(
                  child:   FlatButton(
                  color: Theme.of(context).primaryColor,
                  child: locationData.loading ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ) : Text(
                  'SET DELIVERY ADDRESS',
                  style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async{
                  setState(() {
                  locationData.loading=true;
                  });
                  await locationData.getCurrentPosition();
                  if(locationData.permissionAllowed==true){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => MapScreen()));
                  setState(() {
                  locationData.loading=false;
                  });
                  }else{
                  setState(() {
                  locationData.loading=false;
                  });
                  }
                  },
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.screenHeight! * .095,
              ),
            ],
          ),
        ));
  }
}