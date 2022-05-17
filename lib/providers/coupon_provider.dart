import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class CouponProvider with ChangeNotifier {
  bool? expired;
  DocumentSnapshot? document;
  int discountRate=0;

  getCouponDetails(title, sellerId) async {
    DocumentSnapshot document = await FirebaseFirestore.instance.collection('coupons').doc(title).get();
    if(document.exists){
      this.document = document;
      notifyListeners();
      if((document.data() as Map)['sellerId'] == sellerId) {
        checkExpiry(document);
      }
    } else {
      this.document=null;
      notifyListeners();
    }
  }

  checkExpiry(DocumentSnapshot document){
    DateTime  date = (document.data() as Map)['Expiry'].toDate();
    var dateDiff = date.difference(DateTime.now()).inDays;
    if(dateDiff<0){
      //Expired discount code
      this.expired= true;
      notifyListeners();
    } else {
      this.document = document;
      this.expired=false;
      this.discountRate = (document.data() as Map)['discountRate'];
      notifyListeners();
    }
  }
}
