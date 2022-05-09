import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class PasswordServices with ChangeNotifier{
  String? number;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  getPhone(number){
    this.number = number;
    notifyListeners();
  }
}