import 'package:flutter/material.dart';
import 'package:tengesa/ui/main_screen.dart';
import 'package:tengesa/ui/widget/wavy_header.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _validate = false;
  String _usernameField;
  String _passwordField;
  GlobalKey<FormState> _key = new GlobalKey();

  @override
  void initState() {
    super.initState();
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
            //validator: _productValidator,
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
            //validator: _productValidator,
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
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => MainScreen()));
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
}
