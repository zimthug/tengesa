import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tengesa/ui/shared/appbar.dart';
import 'package:tengesa/ui/stocks_screen/categories_screen.dart';
import 'package:tengesa/ui/stocks_screen/products_screen.dart';
import 'package:tengesa/ui/stocks_screen/stocks_home_screen.dart';
import 'package:tengesa/utils/colors.dart';
import 'package:tengesa/utils/strings.dart';

class StocksMainScreen extends StatefulWidget {
  @override
  _StocksMainScreenState createState() => _StocksMainScreenState();
}

class _StocksMainScreenState extends State<StocksMainScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, initialIndex: 0, length: 3);
    _tabController.addListener(_handleTabIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue.shade900,
        title: new Text(
          Strings.appName,
          style: TextStyle(
              fontFamily: 'Raleway', fontSize: 16, color: Colors.white),
        ),
        elevation: 0.7,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: <Widget>[
            Tab(
              text: "Stocks",
              icon: Icon(FontAwesomeIcons.balanceScale),
            ),
            Tab(
              text: "Products",
              icon: Icon(FontAwesomeIcons.cubes),
            ),
            Tab(
              text: "Categories",
              icon: Icon(FontAwesomeIcons.folderOpen),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          StocksHomeScreen(),
          ProductsScreen(),
          CategoriesScreen(),
        ],
      ),
    );
  }

  void _handleTabIndex() {
    setState(() {});
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabIndex);
    _tabController.dispose();
    super.dispose();
  }
}
