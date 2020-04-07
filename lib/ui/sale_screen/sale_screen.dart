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
    _saveData();
  }

  Future<List<Category>> _futureCat;

  DbManager db = DbManager();

  StreamController<int> streamController = new StreamController<int>();

  _saveData() async {
    Category cat1 = Category(10, 1001, 'Grocery');

    Category cat2 = Category(11, 1001, 'Fashion');

    Category cat3 = Category(12, 1001, 'Menswear');

    Category cat4 = Category(13, 1001, 'Hardware');

    Category cat5 = Category(14, 1001, 'Food');

    await db.saveData(cat1);
    await db.saveData(cat2);
    await db.saveData(cat3);
    await db.saveData(cat4);
    await db.saveData(cat5);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar.getAppBar(context),
      //drawer: NavigationDrawer(),
      body: FutureBuilder<List<Category>>(
        future: db.getCategoryData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());

          return ListView(
            children: snapshot.data
                .map((category) => ListTile(
                      title: Text(category.category),
                      subtitle: Text(category.categoryId.toString()),
                      leading: CircleAvatar(
                        backgroundColor: Colors.red,
                        child: Text(category.category[0],
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                            )),
                      ),
                    ))
                .toList(),
          );
        },
      ),
      bottomNavigationBar: BottomNavigator(),
    );
  }

  Widget _buildBody() {
    return Container(
      width: 340,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            child: FutureBuilder<List<Category>>(
              future: _futureCat,
              builder: (context, snapshot) {
                // not setstate here
                if (snapshot.hasError) {
                  return Text('Error ${snapshot.error}');
                }

                if (snapshot.hasData) {
                  streamController.sink.add(snapshot.data.length);
                  // gridview
                  return _buildCategoryListView(snapshot);
                }
                return Center(
                  child: circularProgress(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  _buildCategoryListView(AsyncSnapshot<List<Category>> snapshot) {}

  circularProgress() {
    return Center(
      child: const CircularProgressIndicator(),
    );
  }
}
