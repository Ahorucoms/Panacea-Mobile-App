import 'package:cloud_firestore/cloud_firestore.dart';

class DependantServices {
  String collection = 'dependant';
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CollectionReference dependent =
      FirebaseFirestore.instance.collection('dependant');
  getDependant() {
    return _firestore
        .collection(collection)
        .where('accVerified', isEqualTo: true)
        .where('usersPhoneNumber', isEqualTo: '0760')
        .orderBy('usersId')
        .snapshots();
  }

  //create new user
  Future<void> createDependantData(Map<String, dynamic> values) async {
    String id = values['id'];
    await dependent.doc(id).set(values);
  }
}
//This will show only verified Dependant