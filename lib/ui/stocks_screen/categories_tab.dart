import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tengesa/model/category.dart';
import 'package:tengesa/model/category_products.dart';
import 'package:tengesa/utils/database/db_manager.dart';

class CategoriesTab extends StatefulWidget {
  @override
  _CategoriesTabState createState() => _CategoriesTabState();
}

class _CategoriesTabState extends State<CategoriesTab> {
  @override
  void initState() {
    super.initState();
    //_saveData();
    //_futureCategories = db.getCategoryWithProductCount(1001);
    _getData();
  }

  bool _validate = false;
  String _categoryField;
  DbManager db = DbManager();
  GlobalKey<FormState> _key = new GlobalKey();
  Future<List<CategoryProducts>> _futureCategories;
  //StreamController<int> streamController = new StreamController<int>();

  _getData() {
    _futureCategories = db.getCategoryWithProductCount(1001);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Card(
            elevation: 4.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Icon(
                        Icons.create_new_folder,
                        color: Colors.grey[500],
                      ),
                      FlatButton(
                        child: Text(
                          "New Category",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                        onPressed: () {
                          showCategoryDialog();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<CategoryProducts>>(
              future: _futureCategories,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error ${snapshot.error}');
                }
                if (snapshot.hasData) {
                  //return Container();
                  //streamController.sink.add(snapshot.data.length);
                  return ListView(
                    children: snapshot.data
                        .map((categoryProduct) => ListTile(
                              title: Text(categoryProduct.category),
                              subtitle:
                                  Text(categoryProduct.categoryId.toString()),
                              leading: CircleAvatar(
                                backgroundColor: Colors.red,
                                child: Text(categoryProduct.products.toString(),
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.white,
                                    )),
                              ),
                            ))
                        .toList(),
                  );
                }
                if (!snapshot.hasData) {
                  return Center(
                    child: Text(
                      "No Categories Defined",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.pinkAccent,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  showCategoryDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                child: Material(
                  clipBehavior: Clip.antiAlias,
                  elevation: 2.0,
                  borderRadius: BorderRadius.circular(4.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Card(
                          clipBehavior: Clip.antiAlias,
                          elevation: 0.0,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  "Create Category",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(15),
                                child: Form(
                                  key: _key,
                                  autovalidate: _validate,
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        keyboardType: TextInputType.text,
                                        textCapitalization:
                                            TextCapitalization.words,
                                        maxLength: 60,
                                        style: TextStyle(color: Colors.black),
                                        decoration: InputDecoration(
                                          labelStyle: TextStyle(
                                              fontWeight: FontWeight.w300),
                                          labelText: "Category",
                                          border: OutlineInputBorder(),
                                          contentPadding:
                                              const EdgeInsets.all(10.0),
                                        ),
                                        validator: _categoryValidator,
                                        onSaved: (String val) {
                                          _categoryField = val;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Card(
                          clipBehavior: Clip.antiAlias,
                          elevation: 0.0,
                          color: Colors.grey.shade200,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              FlatButton(
                                child: Text("Cancel"),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              FlatButton(
                                child: Text("Save"),
                                onPressed: () {
                                  _saveCategory();
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _categoryValidator(String val) {
    if (val.length < 2) {
      return 'Category must be at least 2 characters';
    }
  }

  _saveCategory() async {
    if (_key.currentState.validate()) {
      _key.currentState.save();
      //print("Category Name is " + _categoryField);
      int catId = await db.getMaxCategoryId() + 1;
      Category category = Category(catId, 1001, _categoryField);

      await db.saveCategoryData(category);
    }
  }
}