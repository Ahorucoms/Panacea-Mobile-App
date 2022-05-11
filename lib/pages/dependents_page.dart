import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:panacea/pages/search_page.dart';

class DependentScreen extends StatefulWidget {
  const DependentScreen({Key? key}) : super(key: key);

  @override
  State<DependentScreen> createState() => _DependentScreenState();
}

class _DependentScreenState extends State<DependentScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xffE4E3F0),
        centerTitle: true,
        title: Text(
          'ADD DEPENDENT',
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
      body: Container(
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
                                        style: TextStyle(color: Colors.grey),
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
            Container(
              padding: EdgeInsets.all(6),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Offers adn Discounts",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Container(
                          child: DecoratedBox(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.0),
                            color: Color.fromARGB(255, 195, 193, 215)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              "Add dependent",
                              style: TextStyle(
                                  color: Colors.black38, fontSize: 12),
                            ),
                          ),
                        ),
                      ))
                    ],
                  ),
                  Container(
                    height: screenHeight / 1.5,
                    // width: 120,
                    child: GridView.count(
                      // scrollDirection: Axis.horizontal,
                      crossAxisCount: 2,
                      children: [
                        Container(
                          padding: EdgeInsets.all(4),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'images/lydia.jpg',
                                fit: BoxFit.cover,
                              ),
                              Text("title")
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(4),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'images/lydia.jpg',
                                fit: BoxFit.cover,
                              ),
                              Text("title")
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(4),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'images/lydia.jpg',
                                fit: BoxFit.cover,
                              ),
                              Text("title")
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(4),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'images/lydia.jpg',
                                fit: BoxFit.cover,
                              ),
                              Text("title")
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
