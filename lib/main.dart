import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tengesa/model/state/cart_state.dart';
import 'package:tengesa/ui/splash_screen/splash_screen.dart';
import 'package:tengesa/utils/strings.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Oxygen',
        primarySwatch: Colors.lightBlue,
      ),
      home: SplashScreen(),
    );
  }
}
