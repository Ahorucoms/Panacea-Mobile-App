

import 'package:shared_preferences/shared_preferences.dart';

class UserSimplePreferences {
  static SharedPreferences? _preferences;

  static const _keyNumber = 'number';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setNumber(String number) async{
    await _preferences!.setString(_keyNumber, number);
  }
  static String? getNumber(){
    _preferences!.getString(_keyNumber);
  }
}