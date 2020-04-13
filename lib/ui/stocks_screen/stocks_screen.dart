import 'package:flutter/material.dart';

import 'package:tengesa/ui/shared/appbar.dart';
import 'package:tengesa/ui/shared/bottom_navigator.dart';
import 'package:tengesa/ui/stocks_screen/categories_tab.dart';
import 'package:tengesa/ui/stocks_screen/products_tab.dart';
import 'package:tengesa/utils/database/db_manager.dart';

class StocksScreen extends StatefulWidget {
  StocksScreen({Key key}) : super(key: key);

  @override
  _StocksScreenState createState() => _StocksScreenState();
}

class _StocksScreenState extends State<StocksScreen>
    with TickerProviderStateMixin {
  int countCats;
  bool _saleInProgress = true;
  bool _validate = false;
  DbManager db = DbManager();
  GlobalKey<FormState> _key = new GlobalKey();

  Size size;

  @override
  void initState() {
    super.initState();
    _saleInProgress = true;
    //size = MediaQuery.of(context).size;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar.getAppBar(context),
      body: _body(),
      bottomNavigationBar: BottomNavigator(),
    );
  }

  Widget _body() {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
      return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: viewportConstraints.maxHeight),
          child: Column(
            children: [
              Container(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Stock Manager",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: Form(
                        key: _key,
                        autovalidate: _validate,
                        child: _gridMenu(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _gridMenu() {
    size = MediaQuery.of(context).size;
    TabController tabController = new TabController(length: 2, vsync: this);

    return Center(
      child: Container(
        padding: EdgeInsets.all(5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            TabBar(
              controller: tabController,
              tabs: <Widget>[
                Tab(
                  child: Text(
                    "Products",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w700),
                  ),
                ),
                Tab(
                  child: Text(
                    "Categories",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
              height: 400,              
              child: TabBarView(
                controller: tabController,
                children: <Widget>[
                  ProductsTab(),
                  CategoriesTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}