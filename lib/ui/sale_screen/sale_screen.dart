import 'package:flutter/material.dart';
import 'package:tengesa/model/sales_grid.dart';
import 'package:tengesa/ui/sale_screen/make_sale_screen.dart';
import 'package:tengesa/ui/widget/sales_gridlist_item.dart';

class SaleScreen extends StatefulWidget {
  @override
  _SaleScreenState createState() => _SaleScreenState();
}

class _SaleScreenState extends State<SaleScreen> {
  @override
  void initState() {
    super.initState();
    //_saveData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    var size = MediaQuery.of(context).size;
    final Orientation orientation = MediaQuery.of(context).orientation;

    final double itemWidth = size.width / 2;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 4;

    List<SalesGrid> salesGrid = <SalesGrid>[
      SalesGrid("Sales", MakeSaleScreen(), "assets/images/shopping_cart.png"),
      SalesGrid("Stocks", new Container(), "assets/images/shopping_bags.png"),
      SalesGrid("Invoice", new Container(), "assets/images/page_with_curl.png"),
      SalesGrid("Till Status", new Container(), "assets/images/moneybag.png"),
      SalesGrid("Deliveries", new Container(), "assets/images/truck.png"),
      SalesGrid("Reports", new Container(), "assets/images/ledger.png")
    ];

    return Padding(
      padding: EdgeInsets.fromLTRB(10, 40, 10, 10),
      child: Column(
        children: <Widget>[
          Expanded(
            child: SafeArea(
              top: false,
              bottom: false,
              child: GridView.count(
                crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3,
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
                padding: const EdgeInsets.all(4.0),
                childAspectRatio: (itemWidth / itemHeight),
                //(orientation == Orientation.portrait) ? 1.0 : 1.3,
                children: salesGrid.map<Widget>(
                  (SalesGrid gridData) {
                    return GestureDetector(
                      child: GridTile(
                        child: SalesGridListItem(gridData),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => gridData.widget,
                          ),
                        );
                      },
                    );
                  },
                ).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
