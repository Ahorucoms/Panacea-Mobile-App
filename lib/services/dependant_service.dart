

import 'package:cloud_firestore/cloud_firestore.dart';

class DependantServices{
  getDependant(){
    return FirebaseFirestore.instance.collection('dependant')
        .where('accVerified',isEqualTo: true)
        .where('usersPhoneNumber',isEqualTo: '0760')
        .orderBy('usersId')
        .snapshots();
  }
}
//This will show only verified Dependant