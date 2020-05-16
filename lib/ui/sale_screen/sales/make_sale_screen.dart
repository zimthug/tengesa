import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/material.dart';
import 'package:tengesa/model/product.dart';
import 'package:tengesa/ui/shared/appbar.dart';
import 'package:tengesa/utils/colors.dart';
import 'package:tengesa/utils/database/db_manager.dart';

class MakeSaleScreen extends StatefulWidget {
  @override
  _MakeSaleScreenState createState() => _MakeSaleScreenState();
}

class _MakeSaleScreenState extends State<MakeSaleScreen> {
  DbManager db = DbManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar.getAppBar(context),
      body: _body(),
    );
  }

  Widget _body() {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 40, 10, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                "Maintain",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 8),
              Text(
                "Sale Items",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          Expanded(
            child: searchArea(),
          ),
          createSaleProductsList()
        ],
      ),
    );
  }

  Widget searchArea() {
    return SearchBar<ProductDetails>(
      searchBarPadding: EdgeInsets.symmetric(horizontal: 10),
      headerPadding: EdgeInsets.symmetric(horizontal: 10),
      listPadding: EdgeInsets.symmetric(horizontal: 10),
      onSearch: _findProducts,
      //searchBarController: _searchBarController,
      placeHolder: Text("Search Products"),
      cancellationWidget: Text("Stop"),
      emptyWidget: Text("No Products"),
      onItemFound: (ProductDetails product, int productId) {
        return ListTile(
          title: Text(product.product),
          subtitle: Text(
            "RTGS" +
                product.rtgs.toString() +
                " ... USD" +
                product.usd.toString(),
          ),
          onTap: () {
            print("Picked "+product.product);
          },
        );
      },
      searchBarStyle: SearchBarStyle(
          borderRadius: BorderRadius.circular(40),
          backgroundColor: Colors.grey.shade200),
    );
  }

  Widget createSaleProductsList() {
    return Column();
  }

  Future<List<ProductDetails>> _findProducts(String search) async {
    //await Future.delayed(Duration(seconds: 2));
    return db.findProductsDetailsByName(search);
  }

  Widget _productSearchDialog() {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Container(
            padding:
                EdgeInsets.only(top: 44.0, bottom: 5.0, left: 5.0, right: 5.0),
            margin: EdgeInsets.only(top: 44.0),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    offset: const Offset(0.0, 10.0))
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "Choose Product",
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w800),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Divider(
                  color: AppColors.primaryColor,
                  height: 10.0,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Submit"),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 16.0,
            right: 16.0,
            child:
                CircleAvatar(backgroundColor: Colors.deepOrange, radius: 44.0),
          )
        ],
      ),
    );
  }
}
