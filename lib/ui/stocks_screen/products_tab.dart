import 'package:flutter/material.dart';
import 'package:tengesa/model/product.dart';
import 'package:tengesa/ui/stocks_screen/edit_product_screen.dart';

import 'package:tengesa/utils/database/db_manager.dart';

class ProductsTab extends StatefulWidget {
  @override
  _ProductsTabState createState() => _ProductsTabState();
}

class _ProductsTabState extends State<ProductsTab> {
  @override
  void initState() {
    super.initState();
    getProductDetailsData();
  }

  DbManager db = DbManager();
  Future<List<ProductDetails>> _futureProductDetails;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Card(
            elevation: 8.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.input),
                        color: Colors.grey[500],
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => EditProductScreen()));
                        },
                      ),
                      FlatButton(
                        child: Text(
                          "New Product",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                        onPressed: () {
                          //showProductDialog();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => EditProductScreen()));
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.0),
          Expanded(
            child: FutureBuilder<List<ProductDetails>>(
              future: _futureProductDetails,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error ${snapshot.error}');
                }
                if (snapshot.hasData) {
                  return _productsListView(snapshot);
                }
                if (!snapshot.hasData) {
                  return Center(
                    child: Text(
                      "No Products Found",
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

  Widget _productsListView(AsyncSnapshot<List<ProductDetails>> snapshot) {
    return RefreshIndicator(
      onRefresh: getProductDetailsData,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: Card(
                elevation: 8.0,
                margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                child: Container(
                  decoration: BoxDecoration(color: Colors.grey.shade100),
                  child: ListTile(
                    isThreeLine: true,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    leading: Container(
                      padding: EdgeInsets.only(right: 5.0),
                      decoration: BoxDecoration(
                        border: Border(
                            right:
                                BorderSide(width: 1.0, color: Colors.white24)),
                      ),
                      child: Icon(
                        Icons.grain,
                        color: Colors.blue,
                      ),
                    ),
                    title: Text(
                      snapshot.data[index].product,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Align(
                              alignment: Alignment.topLeft,
                              child:                            Text(
                              "ZW\$ " + snapshot.data[index].rtgs.toString(),
                              style: TextStyle(
                                color: Colors.teal,
                                fontSize: 12,
                              ),
                            ),),
                            Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                "US\$ " + snapshot.data[index].usd.toString(),
                                style: TextStyle(
                                  color: Colors.orangeAccent,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Ecocash\$ " +
                                  snapshot.data[index].ecocash.toString(),
                              style: TextStyle(
                                color: Colors.purpleAccent,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing:
                        Icon(Icons.keyboard_arrow_right, color: Colors.blue, size: 30),
                  ),
                ),
              ),
            );
          }),
    );
  }

  Future<void> getProductDetailsData() {
    _futureProductDetails = db.getProductsDetails(0, 0);
  }
}
