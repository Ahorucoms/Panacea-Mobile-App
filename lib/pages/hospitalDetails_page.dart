import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class HospitalDetailsPage extends StatefulWidget {
  String code, name, address, history;

  HospitalDetailsPage(
      {required this.code,
      required this.name,
      required this.address,
      required this.history});

  @override
  State<HospitalDetailsPage> createState() => _HospitalDetailsPageState();
}

class _HospitalDetailsPageState extends State<HospitalDetailsPage> {
  FirebaseDatabase database = FirebaseDatabase.instance;
  List<Map<dynamic, dynamic>> services = [];
  getServices() async {
    final snapshot = await database.ref('services').get();
    // database.ref().child('users').orderByChild('name').equalTo('John Doe').onValue("hhhh",);
    if (snapshot.exists) {
      //  snapshot.
      var values = snapshot.value;

      print(snapshot.value);
    } else {
      print('No data available.');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getServices();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      // backgroundCol
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xffE4E3F0),
        centerTitle: true,
        title: Text(
          widget.name,
          style: TextStyle(color: Colors.black),
        ),
      ),
      bottomNavigationBar: TextButton(
        child: Text("Book an Appointment"),
        onPressed: () {},
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: ListView(
          children: [
            Container(
              height: 100,
              child: GridTile(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: EdgeInsets.only(left: 8, right: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(widget.name),
                            Text(
                              widget.address,
                              textAlign: TextAlign.center,
                              style: TextStyle(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Image.asset(
                        "images/hospital.png",
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: FutureBuilder(
                    future: database.ref("services").get(),
                    builder: (context, AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.hasData) {
                        services.clear();
                        Map<dynamic, dynamic> values = snapshot.data.value;

                        values.forEach((key, values) {
                          values['uid'] = key;
                          if (values['code'] == widget.code) {
                            services.add(values);
                          }
                        });
                        print(services);
                      }
                      return RaisedButton(
                        // color: Colors.greenAccent,
                        onPressed: () {},
                        // textColor: Colors.white,
                        elevation: 0.2,
                        child: Text('${services.length} services'),
                      );
                    },
                  ),
                ),
              ],
            ),
            Divider(),
            ListTile(
              title: Text(
                'History',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(widget.history),
            ),
            ListTile(
              title: Text(
                'Schedule',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              // subtitle: Text(widget.history),
            ),
          ],
        ),
      ),
    );
  }
}
