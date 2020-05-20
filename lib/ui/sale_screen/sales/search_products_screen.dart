//import 'package:flappy_search_bar/flappy_search_bar.dart';
//import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tengesa/model/product.dart';
import 'package:tengesa/ui/widget/search_widget.dart';
import 'package:tengesa/utils/colors.dart';
import 'package:tengesa/utils/database/db_manager.dart';

class SearchProductsScreen extends StatefulWidget {
  @override
  _SearchProductsScreenState createState() => _SearchProductsScreenState();
}

class _SearchProductsScreenState extends State<SearchProductsScreen> {
  String term;
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
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              height: 100,
              color: AppColors.primaryColor,
              child: ConstrainedBox(
                constraints:
                    BoxConstraints(minWidth: MediaQuery.of(context).size.width),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    height: 20,
                    //color: Colors.white,
                    child: TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        hintText: 'Search Products...',
                        icon: Icon(Icons.search),
                      ),
                      onChanged: onItemChanged,
                    ),
                  ), //SearchWidget(searchbarText: "Search Products"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Filter Products ",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                  ),
                  _categoriesFilter()
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                height: MediaQuery.of(context).size.height / 1.8,
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
        if (snapshot.hasData) {
          //snapshot.data.where((string) => string.product.toLowerCase().contains(term.toLowerCase()));
          return _productsListViewBuilder(snapshot);
        }
        if (!snapshot.hasData) {
          return Center(
            child: Text(
              "No Products Found",
              style: TextStyle(
                fontSize: 16.0,
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
                                "ZW\$ " + snapshot.data[index].rtgs.toString(),
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "US\$ " + snapshot.data[index].usd.toString(),
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Ecocash\$ " +
                                    snapshot.data[index].ecocash.toString(),
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
                            snapshot.data[index].currentStock.toString(),
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              onTap: () {
                print("Picked " + snapshot.data[index].product);
              },
            );
          }),
    );
  }

  Future<void> _getProductDetailsData() {
    _futureProductDetails = db.getProductsDetails(0, 0);
  }
}
