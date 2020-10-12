import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tengesa/utils/database/db_initialize.dart';
import 'package:tengesa/utils/database/db_manager.dart';

class UserStateModel with ChangeNotifier {
  DbManager db = DbManager();

  Future<bool> checkLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var initialized = prefs.getBool("tengesa.initialized");

    if (!initialized) {
      InitializeDb initDb = InitializeDb();
      initDb.intializeDatabase();
      initDb.intializeTestUser();
      prefs.setBool("tengesa.initialized", true);
    }

    var username = prefs.getString("tengesa.username");
    var password = prefs.getString("tengesa.pasword");

    if (username == null && password == null) {
      return false;
    }

    return true;
  }

  Future<String> loginUser(String username, String password) async {
    var userList = await db.findUserByUsername(username);

    if (userList == null) {
      return "Invalid Username or Password";
    }

    var user = userList[0];

    if (user.password != password) {
      return "Invalid Username or Password";
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();

    //Set username and password
    prefs.setString("tengesa.role", user.role);
    prefs.setString("tengesa.username", user.username);
    prefs.setInt("tengesa.branchId", user.branchId);

    return "OK";
  }
}
