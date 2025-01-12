import 'package:flutter/material.dart';
 import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtils{

  /// Instantiation of the shared preferences
  ///

  static final String _kUserUID = "uid";
  static final String _kUserEmail ="user_email";
  static final String _kUserDisplayName = "user_name";
  static final String _kUserFirstLaunch = "first_launch";


  // getter firstlaunch
  static Future<bool> getisFirstLaunch() async{

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getBool(_kUserFirstLaunch) ?? true;

  }

  //setter firstlaunch
  static Future<bool> setisFirstLaunch(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setBool(_kUserFirstLaunch, value);
  }

  // getter uid
  static Future<String> getUserUID() async{

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_kUserUID) ?? '';

  }

  //setter uid
  static Future<bool> setUserUid(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(_kUserUID, value);
  }



  // getter email
  static Future<String> getUserEmail() async{

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_kUserEmail) ?? '';

  }

  //setter email
  static Future<bool> setUserEmail(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(_kUserEmail, value);
  }



  // getter displayname
  static Future<String> getUserDisplayName() async{

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_kUserDisplayName) ?? '';

  }

  //setter displayname
  static Future<bool> setUserDisplayName(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(_kUserDisplayName, value);
  }





}