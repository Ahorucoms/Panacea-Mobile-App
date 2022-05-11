import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool isLoading = true;
  late String keyword, keywordToSearch;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    keyword = '';
    keywordToSearch = '';
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: Container(
            height: 60.0,
            child: Stack(
              children: [
                Positioned(
                  top: 10.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    height: 40,
                    padding: EdgeInsets.symmetric(horizontal: 0.0),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                          border: Border.all(
                              color: HexColor("#9D0208").withOpacity(0.5),
                              width: 1.0),
                          color: Colors.white),
                      child: Center(
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                onChanged: ((value) {
                                  setState(() {
                                    keyword = value;
                                  });
                                }),
                                decoration: InputDecoration(
                                  hintText: "Search",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50))),
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.search,
                                color: HexColor("#9D0208"),
                              ),
                              onPressed: () {
                                print(keywordToSearch);

                                print("your menu action here");
                              },
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
        ),
        body: keywordToSearch.isEmpty
            ? Center(child: Text(""))
            : isLoading
                ? Center()
                // : FutureBuilder<List<Product>>(
                //     future: fetchProducts(),
                //     builder: (context, snapshot) {
                //       if (snapshot.hasData) {
                //         return GridView.builder(
                //             itemCount: 100,
                //             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //                 crossAxisCount: 2),
                //             itemBuilder: (BuildContext context, int index) {
                //               return Consumer<CartStore>(
                //                 builder: (context, cart, child) => SingleProd(
                //                   product: snapshot.data,
                //                 ),
                //               );
                //             });
                //       } else {
                //         return CircularProgressIndicator();
                //       }
                //     });
                : Container(
                    padding: EdgeInsets.all(16),
                    height: screenHeight,
                  ));
  }
}
