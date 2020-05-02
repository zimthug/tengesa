import 'package:flutter/material.dart';
import 'package:tengesa/utils/strings.dart';

class MyAppBar {
  static getAppBar(context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.blue.shade900,
      title: Text(
        Strings.appName,
        style:
            TextStyle(fontFamily: 'Raleway', fontSize: 16, color: Colors.white),
      ),
    );
  }
}
