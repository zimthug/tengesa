import 'package:flutter/material.dart';
import 'package:tengesa/model/product.dart';
import 'package:tengesa/ui/shared/appbar.dart';
import 'package:tengesa/ui/shared/bottom_navigator.dart';
import 'package:tengesa/ui/stocks_screen/stocks_screen.dart';
import 'package:tengesa/utils/database/db_manager.dart';

class EditProductScreen extends StatefulWidget {
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen>
    with SingleTickerProviderStateMixin {
  bool _validate = false;
  int _categoryField;
  String _productField;
  double _stockMinimum;
  double _stockMaximum;
  double _stockCurrent;
  double _amountUSDField;
  double _amountBondField;
  double _amountEcocashField;
  String _productCodeField;
  DbManager db = DbManager();
  GlobalKey<FormState> _key = new GlobalKey();

  List<DropdownMenuItem> _categoryItems = [];

  @override
  void initState() {
    super.initState();
    _populateCategoryDropDownItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar.getAppBar(context),
      body: _buildBody(),
      //bottomNavigationBar: BottomNavigator(),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      top: false,
      bottom: false,
      child: Form(
        key: _key,
        autovalidate: _validate,
        child: _productForm(),
      ),
    );
  }

  Widget _productForm() {

    return ListView(
      padding: EdgeInsets.fromLTRB(10, 40, 10, 10),   //symmetric(horizontal: 16.0),
      children: <Widget>[
        Text("Create/ Edit Product", style: TextStyle(fontSize: 22, ),),
        SizedBox(height: 20),
        TextFormField(
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.words,
          maxLength: 60,
          decoration: InputDecoration(
            icon: Icon(Icons.local_grocery_store),
            labelStyle: TextStyle(fontWeight: FontWeight.w300),
            labelText: "Product",
          ),
          validator: _productValidator,
          onSaved: (String val) {
            _productField = val;
          },
        ),
        TextFormField(
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.words,
          maxLength: 15,
          style: TextStyle(color: Colors.blue.shade900),
          decoration: InputDecoration(
            icon: Icon(Icons.lock_open),
            labelStyle: TextStyle(fontWeight: FontWeight.w300),
            labelText: "Product Code",
          ),
          //validator: _productValidator,
          onSaved: (String val) {
            _productCodeField = val;
          },
        ),
        DropdownButtonFormField(
          items: _categoryItems,
          value: _categoryField,
          hint: Text("Category"),
          isExpanded: true,
          decoration: InputDecoration(
            icon: Icon(Icons.category),
            labelStyle: TextStyle(fontWeight: FontWeight.w300),
          ),
          onChanged: (val) {
            setState(() {
              if (val != null) {
                _categoryField = val;
              }
            });
          },
        ),
        SizedBox(height: 15),
        Row(
          children: <Widget>[
            Text("Stocks",
                style: TextStyle(
                    color: Colors.blue.shade900,
                    fontWeight: FontWeight.bold,
                    fontSize: 16))
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Flexible(
              child: TextFormField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                style: TextStyle(color: Colors.blue.shade900),
                decoration: InputDecoration(
                  labelStyle: TextStyle(fontWeight: FontWeight.w300),
                  labelText: "Current",
                  contentPadding: const EdgeInsets.all(8.0),
                ),
                //validator: _unitsValidator,
                onSaved: (String val) {
                  _stockCurrent = double.parse(val);
                },
              ),
            ),
            SizedBox(width: 10.0),
            Flexible(
              child: TextFormField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                style: TextStyle(color: Colors.blue.shade900),
                decoration: InputDecoration(
                  labelStyle: TextStyle(fontWeight: FontWeight.w300),
                  labelText: "Minimum",
                  contentPadding: const EdgeInsets.all(8.0),
                ),
                //validator: _unitsValidator,
                onSaved: (String val) {
                  _stockMinimum = double.parse(val);
                },
              ),
            ),
            SizedBox(width: 15.0),
            Flexible(
              child: TextFormField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                style: TextStyle(color: Colors.blue.shade900),
                decoration: InputDecoration(
                  labelStyle: TextStyle(fontWeight: FontWeight.w300),
                  labelText: "Maximum",
                  contentPadding: const EdgeInsets.all(8.0),
                ),
                //validator: _unitsValidator,
                onSaved: (String val) {
                  _stockMaximum = double.parse(val);
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 15),
        Row(
          children: <Widget>[
            Text("Prices",
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold))
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Flexible(
              child: TextFormField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                style: TextStyle(color: Colors.blue.shade900),
                decoration: InputDecoration(
                  labelStyle: TextStyle(fontWeight: FontWeight.w300),
                  labelText: "RTGS\$",
                  contentPadding: const EdgeInsets.all(8.0),
                ),
                //validator: _unitsValidator,
                onSaved: (String val) {
                  _amountBondField = double.parse(val);
                },
              ),
            ),
            SizedBox(width: 10.0),
            Flexible(
              child: TextFormField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                style: TextStyle(color: Colors.blue.shade900),
                decoration: InputDecoration(
                  labelStyle: TextStyle(fontWeight: FontWeight.w300),
                  labelText: "Ecocash",
                  contentPadding: const EdgeInsets.all(8.0),
                ),
                //validator: _unitsValidator,
                onSaved: (String val) {
                  _amountEcocashField = double.parse(val);
                },
              ),
            ),
            SizedBox(width: 15.0),
            Flexible(
              child: TextFormField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                style: TextStyle(color: Colors.blue.shade900),
                decoration: InputDecoration(
                  labelStyle: TextStyle(fontWeight: FontWeight.w300),
                  labelText: "US\$",
                  contentPadding: const EdgeInsets.all(8.0),
                ),
                //validator: _unitsValidator,
                onSaved: (String val) {
                  _amountUSDField = double.parse(val);
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 15),
        Card(
          clipBehavior: Clip.antiAlias,
          elevation: 8.0,
          color: Colors.grey.shade200,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FlatButton(
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => StocksScreen()));
                },
              ),
              SizedBox(
                width: 10,
              ),
              FlatButton(
                child: Text("Save"),
                onPressed: () {
                  _saveProduct();
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => StocksScreen()));
                },
              )
            ],
          ),
        )
      ],
    );
  }

  _populateCategoryDropDownItems() {
    //print("Loading data");
    if (1 == 1) {
      db.getCategoryData().then((value) {
        value.forEach((val) {
          //print(val.category);
          setState(() {
            _categoryItems.add(
              DropdownMenuItem(
                child: Text(val.category),
                value: val.categoryId,
              ),
            );
          });
        });
      });
    }
  }

  String _productValidator(String val) {
    if (val.length < 2) {
      return 'Product must be at least 2 characters';
    }
  }

  _saveProduct() async {
    if (_key.currentState.validate()) {
      _key.currentState.save();

      int productId = await db.getMaxProductId() + 1;
      Product product = Product(
          productId, _categoryField, _productField, _productCodeField, 0);

      await db.saveProductData(product);

      ProductPrice productPriceRtgs =
          ProductPrice(-1, productId, 501, _amountBondField);
      ProductPrice productPriceEcocash =
          ProductPrice(-1, productId, 502, _amountEcocashField);
      ProductPrice productPriceUsd =
          ProductPrice(-1, productId, 503, _amountUSDField);

      await db.saveProductPrice(productPriceRtgs);
      await db.saveProductPrice(productPriceEcocash);
      await db.saveProductPrice(productPriceUsd);

      ProductStock productStock = ProductStock(
          -1, productId, _stockMinimum, _stockMaximum, _stockCurrent);

      await db.saveProductStock(productStock);
    }
  }
}
