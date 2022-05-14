import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:panacea/pages/dependents_page.dart';
import 'package:panacea/pages/search_page.dart';
import 'package:panacea/screens/model/family_dependant.dart';
import 'package:panacea/services/dependant_service.dart';
import 'package:panacea/widgets/dependants.dart';
import 'package:panacea/widgets/size_configs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_database/firebase_database.dart';

class DoctorsPage extends StatefulWidget {
  @override
  State<DoctorsPage> createState() => _DoctorsPageState();
}

class _DoctorsPageState extends State<DoctorsPage> {
  List items = [
    {'image': 'images/linda.jpg', 'title': 'linda'},
    {'image': 'images/lydia.jpg', 'title': 'lydia'},
    {'image': 'images/tomas.jpg', 'title': 'Thomas'},
    {'image': 'images/doctor.png', 'title': 'Doctor'}
  ];
  bool isLoading = true;
  String? uid;
  String? phonep;
  getData() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      uid = prefs.getString("uid").toString();
      phonep = prefs.getString("phone").toString();
      isLoading = false;
    });
  }

  FirebaseDatabase database = FirebaseDatabase.instance;

  @override
  void initState() async {
    // TODO: implement initState
    super.initState();
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('users').get();
    if (snapshot.exists) {
      // print(snapshot.value);
    } else {
      print('No data available.');
    }
    getData();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    String collection = 'dependant';
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xffE4E3F0),
        centerTitle: true,
        title: Text(
          'Find Specialist',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
              height: screenHeight,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  HexColor("#E8EAEF"),
                  HexColor("#E8E7EE"),
                  HexColor("#E8EAEF"),
                ],
              )),
              child: ListView(
                children: [
                  Container(
                    height: 60.0,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 10.0,
                          left: 0.0,
                          right: 0.0,
                          child: Container(
                            height: screenHeight * .065,
                            padding: EdgeInsets.symmetric(horizontal: 6),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50.0),
                                  border: Border.all(
                                      color: HexColor("#9D0208").withOpacity(0),
                                      width: 1.0),
                                  color: Colors.white),
                              child: Center(
                                child: Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        Icons.search,
                                        color: Colors.black,
                                      ),
                                      onPressed: () {
                                        print("your menu action here");
                                      },
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        child: TextButton(
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return SearchPage();
                                              }));
                                              print("ddd");
                                            },
                                            child: Text(
                                              "Search hospitals, pharmacy..",
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                            style: ButtonStyle(
                                              alignment: Alignment.centerLeft,
                                              shape: MaterialStateProperty.all(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50.0))),
                                            )
                                            // decoration: InputDecoration(
                                            //   hintText: "Search",
                                            //   border: OutlineInputBorder(
                                            //       borderRadius: BorderRadius.all(
                                            //           Radius.circular(50))),
                                            // ),
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Row 2 40% of screen
                  Container(
                    padding: EdgeInsets.all(6),
                    child: Column(
                      children: [
                        Container(
                          height: screenHeight / 1.4,
                          child: ListView.builder(
                              itemCount: 40,
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: EdgeInsets.all(4),
                                  child: ListTile(
                                    trailing: IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.more_vert)),
                                    title: Text(
                                      "Dr Renzaho",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(
                                        "PANACEA donated 1 million does of vaccines"),
                                    leading: Image.asset(
                                      'images/tomas.jpg',
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                );
                              }),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
//   Widget buildDependant({
//   required List item,
// }) => Container(
//     width: 200,
//   child:   Column(
//       children: [
//         Expanded(child: Imarge.asset(
//            "${item.}",
//           fit: BoxFit.cover,
//         ))
//
//        // SizedBox(height: 8,),
//
//         // Text(item.title),
//
//       ],
//
//     ),
// );
}
