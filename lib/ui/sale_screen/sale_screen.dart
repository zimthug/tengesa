import 'package:flutter/material.dart';
import 'package:tengesa/ui/shared/appbar.dart';
import 'package:tengesa/ui/shared/bottom_navigator.dart';
import 'package:tengesa/ui/shared/navigation_drawer.dart';

class SaleScreen extends StatefulWidget {
  @override
  _SaleScreenState createState() => _SaleScreenState();
}

class _SaleScreenState extends State<SaleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar.getAppBar(context),
        drawer: NavigationDrawer(),
        body: Container(),
        bottomNavigationBar: BottomNavigator(),
    );
  }
}