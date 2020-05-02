import 'package:flutter/material.dart';
import 'package:tengesa/ui/home_screen/home_screen.dart';
import 'dart:async';

import 'package:tengesa/ui/login_screen/login_screen.dart';
import 'package:tengesa/ui/main_screen.dart';
import 'package:tengesa/utils/strings.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int _statusCode = 200;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<Timer> loadData() async {
    return new Timer(Duration(seconds: 5), onDoneLoading);
  }

  onDoneLoading() async {
    if (_statusCode == 201) {
      //If the user is authenticated then
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen()));
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.blue.shade900,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                Strings.appName,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 42,
                    fontStyle: FontStyle.italic,
                    fontFamily: "Lobster"),
              ),
              SizedBox(height: 30),
              Icon(Icons.beach_access, color: Colors.redAccent, size: 30),
            ],
          ),
        ),
      ),
    );
  }
}
