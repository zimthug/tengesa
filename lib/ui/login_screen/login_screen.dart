import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tengesa/model/user.dart';
import 'package:tengesa/ui/main_screen.dart';
import 'package:tengesa/ui/widget/wavy_header.dart';
import 'package:tengesa/utils/database/db_manager.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isError;
  //bool _loggedIn;
  bool _validate = false;
  String _usernameField;
  String _passwordField;
  DbManager db = DbManager();
  GlobalKey<FormState> _key = new GlobalKey();

  @override
  void initState() {
    super.initState();
    _isError = false;
    //_loggedIn = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              WavyHeaderText(),
              SizedBox(height: 20),
              _isError ? errorCard() : Container(),
              Form(
                key: _key,
                autovalidate: _validate,
                child: loginForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget errorCard() {
    return Card(
      elevation: 8.0,
      child: Text(
        "Invalid Username/ Password",
        style: TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget loginForm() {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 8.0,
      margin: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          TextFormField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              icon: Icon(Icons.person),
              labelStyle: TextStyle(fontWeight: FontWeight.w300),
              labelText: "Username",
            ),
            validator: usernameValidator,
            onSaved: (String val) {
              _usernameField = val;
            },
          ),
          SizedBox(height: 10.0),
          TextFormField(
            keyboardType: TextInputType.text,
            obscureText: true,
            decoration: InputDecoration(
              icon: Icon(Icons.lock),
              labelStyle: TextStyle(fontWeight: FontWeight.w300),
              labelText: "Password",
            ),
            onSaved: (String val) {
              _passwordField = val;
            },
          ),
          SizedBox(height: 10.0),
          ButtonTheme(
            minWidth: 270,
            child: FlatButton(
              child: Text(
                "LOGIN",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontFamily: "Oxygen"),
              ),
              color: Colors.blue.shade900,
              onPressed: () {
                loginUser().then((val) {
                  //print("Data from function is " + val.toString());
                  if (val) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => MainScreen(),
                      ),
                    );
                  } else {
                    setState(() {
                      _isError = true;
                    });
                  }
                });
              },
            ),
          ),
          SizedBox(height: 10.0),
          FlatButton(
            child: Text(
              "Forgot Password?",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: Colors.blueGrey),
            ),
            onPressed: () {},
          ),
          SizedBox(height: 10.0),
          FlatButton(
            child: Text(
              "Register?",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: Colors.blueGrey),
            ),
            onPressed: () {},
          ),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }

  Future<bool> loginUser() async {
    if (_key.currentState.validate()) {
      _key.currentState.save();

      var userList = await db.findUserByUsername(_usernameField);
      //print(userList);
      if (userList == null) {
        return false;
      }

      var user = userList[0];

      if (user.password != _passwordField) {
        return false;
      }

      SharedPreferences prefs = await SharedPreferences.getInstance();

      //Set username and password
      prefs.setString("tengesa.role", user.role);
      prefs.setString("tengesa.username", user.username);
      prefs.setInt("tengesa.branchId", user.branchId);

      return true;
    }

    return false;
  }

  String usernameValidator(String val) {
    if (val.length < 2) {
      return 'Username must be at least 2 characters';
    }
  }
}
