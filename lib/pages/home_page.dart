import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:panacea/screens/model/family_dependant.dart';
import 'package:panacea/widgets/dependants.dart';
import 'package:panacea/widgets/size_configs.dart';



class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  List items =[
  {
    'image':'images/linda.jpg',
  'title':'linda'
},
    {
      'image':'images/lydia.jpg',
      'title':'lydia'
    }
    , {
      'image':'images/tomas.jpg',
      'title':'Thomas'
    }
    , {
      'image':'images/doctor.png',
      'title':'Doctor'
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xffE4E3F0),
        centerTitle: true,
        title: Text('PANACEA', style: TextStyle(color: Colors.black),
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
      body: Padding(
        padding: const EdgeInsets.all(2),
        child: Column(
          children: [
            Expanded(
              flex: 1, // 40% of the screen
                child: Row(
                  children: [
                    Expanded(
                      flex: 8,
                        child: SizedBox(
                          height: SizeConfig.screenHeight! * .200,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.all(12),
                              itemCount: items.length,
                              separatorBuilder: (context, index){
                              return const SizedBox(width: 5,);
                              },
                              itemBuilder: (context, index){
                              return Container(
                                // width: 200,
                                child:   Column(
                                  children: [
                                    Expanded(child:
                                    Column(
                                      children: [
                                        Image.asset(
                                          "${items[index]['image']}",
                                          height: 40,
                                          width: 40,
                                          fit: BoxFit.cover,
                                        ),
                                        Text(items[index]['title']),
                                      ],
                                    ),
                                    ),

                                    // SizedBox(height: 8,),

                                    // Text(items[index]['title'])),

                                  ],

                                ),
                              );;
                              }),
                        ),
                    ),
                    SizedBox(width: 2,),
                    Expanded(
                      flex: 2,
                      child: Container(
                        color: Color(0xFF58AAE8),
                        alignment: Alignment.center,
                        child: Image.asset('images/fingerprint.png',
                        fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                  ],
                )
            ),
            // Row 2 40% of screen
            Expanded(
              flex: 4, // 40% of the screen
              child: Container(
                color: Color(0xFF2AA650),
                alignment: Alignment.center,
                child: Text('Dependant and Search'),
              ),
            ),
            // Row 3 20% of the screen
            SizedBox(width: 2,),
            Expanded(
              flex: 2, // 40% of the screen
              child: Container(
                color: Colors.red,
                alignment: Alignment.center,
                child: Text('Dependant and Search'),
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
