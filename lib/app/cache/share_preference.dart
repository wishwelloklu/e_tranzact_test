import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreferences {
  AppSharedPreferences._();
  static AppSharedPreferences instance = AppSharedPreferences._();

//saving
  saveBoolShare({@required String? key, @required var data}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key!, data);
  }

  Future saveStringShare({required String key, required String data}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
  await  prefs.setString(key, data);
  }

  //getting
  Future<bool> getShareBool(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(key)) {
      return prefs.getBool(key)!;
    }
    return false;
  }

  Future<String?> getShareString(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(key)) {
      return prefs.getString(key)!;
    }
    return null;
  }

//deleting
  Future<void> deleteShareData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(key)) {
      prefs.remove(key).whenComplete(() {
        log("Deleted $key : true");
      });
    }
  }

  Future<void> deleteAllShareData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
