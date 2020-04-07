import 'package:flutter/material.dart';

import 'package:tengesa/ui/shared/appbar.dart';
import 'package:tengesa/ui/shared/bottom_navigator.dart';

class ReportHomeScreen extends StatefulWidget {
  @override
  _ReportHomeScreenState createState() => _ReportHomeScreenState();
}

class _ReportHomeScreenState extends State<ReportHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar.getAppBar(context),
      body: Text("Reports Screen"),
      bottomNavigationBar: BottomNavigator(),
    );
  }
}