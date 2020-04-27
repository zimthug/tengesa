import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tengesa/model/category.dart';
import 'package:tengesa/ui/shared/appbar.dart';
import 'package:tengesa/ui/shared/bottom_navigator.dart';
import 'package:tengesa/ui/shared/navigation_drawer.dart';
import 'package:tengesa/utils/database/db_manager.dart';

class SaleScreen extends StatefulWidget {
  @override
  _SaleScreenState createState() => _SaleScreenState();
}

class _SaleScreenState extends State<SaleScreen> {
  @override
  void initState() {
    super.initState();
    //_saveData();
  }

  Future<List<Category>> _futureCat;

  DbManager db = DbManager();

  StreamController<int> streamController = new StreamController<int>();

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar.getAppBar(context),
      //drawer: NavigationDrawer(),
      body: Container(),
      bottomNavigationBar: BottomNavigator(),
    );
  }

  
}
