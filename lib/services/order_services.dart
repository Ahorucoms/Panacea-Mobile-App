import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderServices{
  CollectionReference orders = FirebaseFirestore.instance.collection('orders');

  Future<DocumentReference>saveOrder(Map<String,dynamic>data){
    var result = orders.add(
      data
    );
    return result;
  }

  Color? statusColor(document) {
    if (document.data()['orderStatus'] == 'Denied') {
      return Colors.red;
    }
    if (document.data()['orderStatus'] == 'Accepted') {
      return Colors.blueGrey[400];
    }
    if (document.data()['orderStatus'] == 'Picking up goods') {
      return Colors.pink[900];
    }
    if (document.data()['orderStatus'] == 'Delivery in progress') {
      return Colors.deepPurpleAccent;
    }
    if (document.data()['orderStatus'] == 'Delivered') {
      return Colors.green;
    }
    return Colors.orange;
  }

  Icon statusIcon(document) {

    if (document.data()['orderStatus'] == 'Accepted') {
      return Icon(Icons.assignment_turned_in_outlined, color: statusColor(document),);
    }
    if (document.data()['orderStatus'] == 'Picking up goods') {
      return Icon(Icons.cases,color: statusColor(document),);

    }
    if (document.data()['orderStatus'] == 'Delivery in progress') {
      return Icon(Icons.delivery_dining,color: statusColor(document),);

    }
    if (document.data()['orderStatus'] == 'Delivered') {
      return Icon(Icons.shopping_bag_outlined,color: statusColor(document),);
    }
    return Icon(Icons.assignment_turned_in_outlined,color: statusColor(document),);
  }

  String statusComment(document){
    if(document.data()['orderStatus']=='Picking up goods'){
      return 'Your order is selected by ${document.data()['deliveryBoy']['name']}';
    }
    if(document.data()['orderStatus']=='On the way'){
      return 'Your delivery person  ${document.data()['deliveryBoy']['name']} moving';
    }
    if(document.data()['orderStatus']=='Delivered'){
      return 'Your order has been completed ';
    }
    return 'Grandparents.${document.data()['deliveryBoy']['name']} successful delivery';
  }
}