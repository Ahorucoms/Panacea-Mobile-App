import 'package:flutter/material.dart';
import './size_configs.dart';

Color kPrimaryColor = Color(0xffFC9D45);
Color kSecondaryColor = Color(0xff573353);
Color kBlackColor = Color(0xff000000);

final kTitle = TextStyle(
  fontFamily: 'Inter',
  fontSize: SizeConfig.blockSizeH! * 7,
  color: kBlackColor,
);

final kBodyText1 = TextStyle(
  color: kBlackColor,
  fontSize: SizeConfig.blockSizeH! * 4.5,
  fontWeight: FontWeight.bold,
);