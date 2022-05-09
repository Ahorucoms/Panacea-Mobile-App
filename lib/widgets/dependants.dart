import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:panacea/screens/model/family_dependant.dart';
import 'package:panacea/services/dependant_service.dart';

class Dependants extends StatefulWidget {

  final double width = 80, aspectRation = 1.02;
  late final FamilyDependant familyDependant;

  Dependants(FamilyDependant familyMember);

  @override
  State<Dependants> createState() => _DependantsState();
}

class _DependantsState extends State<Dependants> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          SizedBox(
              width: widget.width,
              child: Column(
                children: [
                  AspectRatio(aspectRatio: widget.aspectRation,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Image.asset(demoFamilyMembers[0].images[0]),
                    ),
                  ),
                  Text(demoFamilyMembers[0].name,
                    style: TextStyle(color: Colors.black),
                    maxLines: 2,),
                ],
              ),
          ),
        ],
      ),
    );
  }
}
