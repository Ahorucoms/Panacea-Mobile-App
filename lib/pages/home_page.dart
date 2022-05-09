import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:panacea/screens/model/family_dependant.dart';
import 'package:panacea/widgets/dependants.dart';

class CardItem {
   final List<String> urlImages;
   final String title;

  const CardItem({
    required this.urlImages,
    required this.title
});
}

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  List<CardItem> items =[
    CardItem(
      urlImages: [
        'images/linda.jpg',
      ],
      title: 'Linda',
    ),
    CardItem(
      urlImages: [
        'images/lydia.jpg',
      ],
      title: 'Lydia',
    ),
    CardItem(
      urlImages: [
        'images/tomas.jpg',
      ],
      title: 'Thomas',
    ),
    CardItem(
      urlImages: [
        'images/doctor.png',
      ],
      title: 'Doctor',
    ),
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
                          height: 140,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.all(12),
                              itemCount: items.length,
                              separatorBuilder: (context, index){
                              return const SizedBox(width: 12,);
                              },
                              itemBuilder: (context, index){
                              return buildDependant(item: items[index]);
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
  Widget buildDependant({
  required CardItem item,
}) => Container(
    width: 200,
  child:   Column(
      children: [
        Expanded(child: Image.asset(
           "${item.urlImages}",
          fit: BoxFit.cover,
        ))

       // SizedBox(height: 8,),

        // Text(item.title),

      ],

    ),
);
}
