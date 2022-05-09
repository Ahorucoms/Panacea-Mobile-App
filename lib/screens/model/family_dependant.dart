import 'package:flutter/material.dart';

class FamilyDependant {
  late final String name, relation;
  late final List<String> images;
  late final bool isVerified, isPaid;

  FamilyDependant({
    required this.images,
    required this.name,
    required this.relation,
    this.isVerified = false,
    this.isPaid = false,

});
}

// Our demo Family members

List<FamilyDependant> demoFamilyMembers = [
  FamilyDependant(
      images: [
        'images/linda.jpg',
      ],
      name: 'Dieudonne',
      relation: 'Head of Family',
  ),
  FamilyDependant(
      images: ['images/lydia.jpg'],
      name: 'Lydia',
      relation: 'Wife'
  ),
  FamilyDependant(
      images: ['images/tomas.jpg'],
      name: 'Thomas',
      relation: 'brother'
  ),
  FamilyDependant(
      images: ['images/doctor.jpg'],
      name: 'doctor',
      relation: 'doctor'
  ),
];

const String relation = 'Family Member';