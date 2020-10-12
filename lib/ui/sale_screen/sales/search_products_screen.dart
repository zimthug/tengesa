import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:tengesa/model/product.dart';
import 'package:tengesa/model/sales.dart';
import 'package:tengesa/model/state/sales_state.dart';
import 'package:tengesa/utils/colors.dart';
import 'package:tengesa/utils/database/db_manager.dart';

class SearchProductsScreen extends StatefulWidget {
  final VoidCallback onButtonPressed;

  SearchProductsScreen({@required this.onButtonPressed});

  @override
  _SearchProductsScreenState createState() => _SearchProductsScreenState();
}

class _SearchProductsScreenState extends State<SearchProductsScreen> {
  String term;
  Sales sales;
  DbManager db = DbManager();
  int _categoryFilter;
  List<DropdownMenuItem> _categoryItems = [];
  Future<List<ProductDetails>> _futureProductDetails;
  TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    term = null;
    _getProductDetailsData();
    _populateCategoryDropDownItems();
  }

  @override
  Widget build(BuildContext context) {
    
    sales =
        Provider.of<SalesStateModel>(context, listen: false).sale;
    
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              height: 60,
              color: AppColors.primaryColor,
              child: ConstrainedBox(
                constraints:
                    BoxConstraints(minWidth: MediaQuery.of(context).size.width),
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      hintText: 'Search Products',
                      prefixIcon: Icon(Icons.search, size: 30.0),
                      contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      suffixIcon:
                          IconButton(icon: Icon(Icons.clear), onPressed: () {}),
                    ),
                    onChanged: onItemChanged,
                  ),
                ), //SearchWidget(searchbarText: "Search Products"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Filter Products ",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                  ),
                  _categoriesFilter()
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                height: MediaQuery.of(context).size.height / 2,
                child: _productsList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _categoriesFilter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        SizedBox(
          width: 240,
          child: DropdownButton(
            items: _categoryItems,
            value: _categoryFilter,
            isExpanded: true,
            onChanged: (val) {
              setState(() {
                if (val != null) {
                  _categoryFilter = val;
                }
              });
            },
          ),
        ),
      ],
    );
  }

  _populateCategoryDropDownItems() {
    db.getCategoryData().then((value) {
      value.forEach((val) {
        setState(() {
          _categoryItems.add(
            DropdownMenuItem(
              child: Text(
                val.category,
                style: TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w800,
                    fontSize: 14.0),
              ),
              value: val.categoryId,
            ),
          );
        });
      });
    });
  }

  onItemChanged(String value) {
    setState(() {
      /*newDataList = mainDataList
          .where((string) => string.toLowerCase().contains(value.toLowerCase()))
          .toList();*/

      term = value;
      print('Value for term is ' + value);

      //_futureProductDetails =
    });
  }

  Widget _productsList() {
    return FutureBuilder<List<ProductDetails>>(
      future: _futureProductDetails,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error ${snapshot.error}');
        }
        if (snapshot.hasData && sales != null) {
          //snapshot.data.where((string) => string.product.toLowerCase().contains(term.toLowerCase()));
          return _productsListViewBuilder(snapshot);
        }
        if (!snapshot.hasData && sales != null) {
          return Center(
            child: Text(
              "No Products Found",
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.blue.shade600,
                fontWeight: FontWeight.w800,
              ),
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _productsListViewBuilder(
      AsyncSnapshot<List<ProductDetails>> snapshot) {
    return RefreshIndicator(
      onRefresh: _getProductDetailsData,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              child: Container(
                child: Card(
                  elevation: 8.0,
                  margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                  child: Container(
                    decoration: BoxDecoration(color: Colors.grey.shade300),
                    child: ListTile(
                      isThreeLine: true,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
                      title: Text(
                        snapshot.data[index].product,
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "ZW\$ " +
                                    snapshot.data[index].rtgs
                                        .toStringAsFixed(2), //toString(),
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "US\$ " +
                                    snapshot.data[index].usd.toStringAsFixed(2),
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Ecocash \$ " +
                                    snapshot.data[index].ecocash
                                        .toStringAsFixed(2),
                                style: TextStyle(
                                    color: Colors.purple,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                      trailing: Column(
                        children: <Widget>[
                          Icon(FontAwesomeIcons.shoppingBasket),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            snapshot.data[index].currentStock
                                .toStringAsFixed(0),
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              onTap: () {
                double price;
                if (sales.currencyId == 501) {
                  price = snapshot.data[index].rtgs;
                } else if (sales.currencyId == 502) {
                  price = snapshot.data[index].ecocash;
                } else if (sales.currencyId == 503) {
                  price = snapshot.data[index].usd;
                }

                SaleItems saleItems = SaleItems(
                    -1,
                    sales.saleId,
                    snapshot.data[index].productId,
                    1,
                    price,
                    sales.currencyId,
                    price,
                    snapshot.data[index].product);

                Provider.of<SalesStateModel>(context, listen: false).addProduct(saleItems);
                //SalesStateModel salesStateModel = SalesStateModel();
                //salesStateModel.addProduct(saleItems);

                widget.onButtonPressed();
              },
            );
          }),
    );
  }

  Future<void> _getProductDetailsData() {
    _futureProductDetails = db.getProductsDetails(0, 0);
    return null;
  }
}
