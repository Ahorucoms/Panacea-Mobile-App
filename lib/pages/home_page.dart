import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:panacea/pages/dependents_page.dart';
import 'package:panacea/pages/doctors_page.dart';
import 'package:panacea/pages/search_page.dart';
import 'package:panacea/screens/model/family_dependant.dart';
import 'package:panacea/services/dependant_service.dart';
import 'package:panacea/widgets/dependants.dart';
import 'package:panacea/widgets/size_configs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
          'PANACEA',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          GestureDetector(
            child: Container(
              margin: EdgeInsets.only(right: 10),
              child: Icon(
                Icons.notifications_rounded,
                color: Colors.black,
              ),
            ),
          ),
          GestureDetector(
            child: Container(
              margin: EdgeInsets.only(right: 10),
              child: Image.asset('images/parson.png'),
            ),
          )
        ],
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
                    // color: Colors.red,
                    padding: const EdgeInsets.all(2),
                    height: screenHeight * .12,
                    child: Column(
                      children: [
                        Expanded(
                            flex: 1, // 40% of the screen
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 8,
                                  child: Container(
                                    height: screenHeight * .17,
                                    child: StreamBuilder<QuerySnapshot>(
                                        stream: _firestore
                                            .collection(collection)
                                            .where('usersId', isEqualTo: uid)
                                            .snapshots(),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasError) {
                                            return Center(
                                              child: Text("Error"),
                                            );
                                          }
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          }
                                          return ListView.separated(
                                              scrollDirection: Axis.horizontal,
                                              padding: const EdgeInsets.only(
                                                  left: 7, top: 6),
                                              itemCount:
                                                  snapshot.data!.docs.length,
                                              separatorBuilder:
                                                  (context, index) {
                                                return const SizedBox(
                                                  width: 5,
                                                );
                                              },
                                              itemBuilder: (context, index) {
                                                return Column(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: (() {
                                                        Navigator.of(context).push(
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) {
                                                          return DoctorsPage();
                                                        }));
                                                      }),
                                                      child: Image.asset(
                                                        "${items[0]['image']}",
                                                        height: 50,
                                                        width: 50,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    Text(snapshot.data!
                                                        .docs[index]['names']),
                                                  ],
                                                );
                                              });
                                        }),
                                  ),
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    color: Color(0xFF58AAE8),
                                    alignment: Alignment.center,
                                    child: Image.asset(
                                      'images/fingerprint.png',
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),

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
                        Text("Top Health News",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Container(
                          height: screenHeight / 4.7,
                          child: ListView.builder(
                              itemCount: 2,
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: EdgeInsets.all(4),
                                  child: ListTile(
                                    title: Text(
                                      "Vaccines",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(
                                        "PANACEA donated 1 million does of vaccines"),
                                    leading: Image.asset(
                                      'images/fingerprint.png',
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                );
                              }),
                        )
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 2,
                  ),
                  Container(
                    padding: EdgeInsets.all(6),
                    child: Column(
                      children: [
                        Text("Offers adn Discounts",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Container(
                          height: screenHeight / 4.7,
                          // width: 120,
                          child: StreamBuilder<QuerySnapshot>(
                              stream: _firestore
                                  .collection(collection)
                                  .where('usersId', isEqualTo: uid)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                return GridView.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 5,
                                      mainAxisSpacing: 5,
                                    ),
                                    itemCount: snapshot.data?.docs.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        padding: EdgeInsets.all(4),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'images/lydia.jpg',
                                              height: 70,
                                              width: 70,
                                              fit: BoxFit.cover,
                                            ),
                                            Text("title")
                                          ],
                                        ),
                                      );
                                    });
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
//         Expanded(child: Image.asset(
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
