import 'package:flutter/material.dart';
import 'package:tengesa/ui/shared/appbar.dart';
import 'package:tengesa/ui/shared/navigation_drawer.dart';

class MakeSaleScreen extends StatefulWidget {
  @override
  _MakeSaleScreenState createState() => _MakeSaleScreenState();
}

class _MakeSaleScreenState extends State<MakeSaleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar.getAppBar(context),
      //drawer: NavigationDrawer(),
      body: _buildBody(),
    );
  }

  Widget _buildBody(){
    return Container();
  }
}