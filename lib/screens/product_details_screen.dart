import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:panacea/widgets/products/bottom_sheet_container.dart';

class ProductDetailsScreen extends StatelessWidget {
  static const String id = 'product_details_screen';
  final DocumentSnapshot? document;

  ProductDetailsScreen({this.document});

  @override
  Widget build(BuildContext context) {
    var offer = (((document!.data() as Map)['comparedPrice'] - (document!.data() as Map)['price']) / (document!.data() as Map)['comparedPrice']) * 100;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(icon: Icon(CupertinoIcons.search), onPressed: () {}),
        ],
      ),
      bottomSheet: BottomSheetContainer(document!),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(.3),
                    border: Border.all(color: Theme.of(context).primaryColor),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8, bottom: 2, top: 2),
                    child: Text((document!.data() as Map)['brand']),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              (document!.data() as Map)['productName'],
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              (document!.data() as Map)['weight'],
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  '${(document!.data() as Map)['price'].toStringAsFixed(0)}\đ',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 10,
                ),
                if (offer > 0) //if offer available only
                  Text(
                    '${(document!.data() as Map)['comparedPrice']}\đ',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                SizedBox(
                  width: 10,
                ),
                if (offer > 0)
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8, top: 3, bottom: 3),
                      child: Text(
                        '${offer.toStringAsFixed(0)}% OFF',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Hero(
                tag: 'Product${(document!.data() as Map)['productName']}',
                child: Image.network(
                  (document!.data() as Map)['productImage'],
                ),
              ),
            ),
            Divider(
              color: Colors.grey[300],
              thickness: 6,
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                child: Text(
                  'Product information',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Divider(color: Colors.grey[400]),
            Padding(
              padding:
              const EdgeInsets.only(top: 8, bottom: 8, left: 10, right: 10),
              child: ExpandableText(
                (document!.data() as Map)['description'],
                expandText: 'see more',
                collapseText: 'Record',
                maxLines: 2,
                style: TextStyle(color: Colors.grey),
              ),
            ),
            Divider(color: Colors.grey[400]),
            Container(
              child: Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                child: Text(
                  'More information about the product',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Divider(color: Colors.grey[400]),
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10,top: 8,bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Product code :  ${(document!.data() as Map)['sku']}',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    'Seller : ${(document!.data() as Map)['seller']['shopName']}',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            SizedBox(height: 60,)
          ],
        ),
      ),
    );
  }

  Future<void>saveForLater(){
    CollectionReference _favourite = FirebaseFirestore.instance.collection('favourites');
    User? user = FirebaseAuth.instance.currentUser;
    return _favourite.add({
      'product':document!.data(),
      'customerId': user!.uid,
    });
  }
}
