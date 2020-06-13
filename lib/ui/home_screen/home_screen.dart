import 'package:flutter/material.dart';
import 'package:tengesa/ui/home_screen/balance_card.dart';
import 'package:tengesa/ui/sale_screen/sale_screen.dart';
import 'package:tengesa/ui/shared/appbar.dart';
import 'package:tengesa/ui/shared/bottom_navigator.dart';
import 'package:tengesa/ui/shared/home_background.dart';
import 'package:tengesa/ui/shared/navigation_drawer.dart';
import 'package:tengesa/utils/strings.dart';

import 'dashboard_menu_row.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  Size deviceSize;

  DateTime currentBackPressTime = DateTime.now();

  Future<bool> _onWillPop() {
    DateTime now = DateTime.now();
    if (now.difference(currentBackPressTime) > Duration(seconds: 4)) {
      currentBackPressTime = now;
      final snackBar = SnackBar(content: Text(Strings.willPopAlert));
      _scaffoldkey.currentState.showSnackBar(snackBar);
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: _scaffoldkey,
        body: _body(),        
      ),
    );
  }


  Widget _body() {
    return Center(
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          //allCards(context),
        ],
      ),
    );
  }
}
