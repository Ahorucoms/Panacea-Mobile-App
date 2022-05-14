import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:panacea/pages/dependents_page.dart';
import 'package:panacea/pages/personalDetails.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xffE4E3F0),
        centerTitle: true,
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * .007,
            ),
            Container(
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50.0), //or 15.0
                    child: Container(
                      height: 80.0,
                      width: 80.0,
                      color: HexColor("0C2D48"),
                      child: Image.asset(
                        "images/parson.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Column(
                      children: [
                        Text(
                          "names",
                          style: TextStyle(
                            fontSize: 20,
                            color: HexColor("0C2D48"),
                          ),
                        ),
                        Text("email")
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(children: [
                SizedBox(
                  height: 80,
                ),
                InkWell(
                  // onTap: () => Navigator.of(context).push(
                  //     MaterialPageRoute(builder: ((context) => EditProfile()))),
                  child: GestureDetector(
                    onTap: (() {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return PersonalDetailPage();
                      }));
                    }),
                    child: Row(
                      children: [
                        Icon(
                          Icons.person,
                          color: HexColor("0C2D48"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text("Personal Details"),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.payments,
                      color: HexColor("0C2D48"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text("Update/add Payments"),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return DependentScreen();
                    }));
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.group_add,
                        color: HexColor("0C2D48"),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text("Manage Dependants"),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.settings,
                      color: HexColor("0C2D48"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text("Settings"),
                    ),
                  ],
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
