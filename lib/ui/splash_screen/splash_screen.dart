import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

import 'package:tengesa/ui/login_screen/login_screen.dart';
import 'package:tengesa/ui/main_screen.dart';
import 'package:tengesa/utils/database/db_initialize.dart';
import 'package:tengesa/utils/database/db_manager.dart';
import 'package:tengesa/utils/strings.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool loggedIn = false;
  DbManager db = DbManager();
  InitializeDb initDb = InitializeDb();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<Timer> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //var pc = prefs.getBool("tengesa.initialized");
    var pc = prefs.getInt("tengesa.initg");

    if (pc == null || pc == 0) {
        initDb.intializeDatabase();
        initDb.intializeTestUser();
      //prefs.setBool("tengesa.initialized", true);
      prefs.setInt("tengesa.initg", 1);
    }

    /*
    if (prefs.getBool("tengesa.loggedin")) {
      loggedIn = true;
    }
    */

    var username = prefs.getString("tengesa.username");

    if (username != null) {
      loggedIn = true;
    }

    return new Timer(Duration(seconds: 5), onDoneLoading);
  }

  onDoneLoading() async {
    if (loggedIn) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => MainScreen()));
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
