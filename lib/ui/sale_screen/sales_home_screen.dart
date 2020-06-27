import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:tengesa/model/state/sales_state.dart';
import 'package:tengesa/ui/sale_screen/sales/make_sale_screen.dart';
import 'package:tengesa/ui/sale_screen/sales/sales_list_screen.dart';

class SalesHomeScreen extends StatefulWidget {
  @override
  _SalesHomeScreenState createState() => _SalesHomeScreenState();
}

class _SalesHomeScreenState extends State<SalesHomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                "Where do you want to be?",
                style: TextStyle(
                    fontSize: 28,
                    color: Colors.deepOrangeAccent,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Nunito"),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Expanded(child: _buildBody()),
      ],
    ));
  }

  Widget _buildBody() {
    return StaggeredGridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 12.0,
      mainAxisSpacing: 12.0,
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      children: <Widget>[
        _buildTile(
          Colors.indigoAccent,
          Padding(
            padding: EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[],
            ),
          ),
        ),
        _buildTile(
            Colors.red,
            Padding(
              padding: EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Icon(Icons.shopping_cart,
                        size: 40, color: Colors.blueAccent.shade400),
                    height: 80,
                  ),
                  Text(
                    "New Sale",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.blueAccent),
                  ),
                ],
              ),
            ), onTap: () {
          ScopedModel.of<SalesStateModel>(context).addSale();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => MakeSaleScreen(),
            ),
          );
        }),
        _buildTile(
          Colors.purple,
          Padding(
            padding: EdgeInsets.all(24.0),
            child: Column(),
          ),
        ),
        _buildTile(
          Colors.blue,
          Padding(
            padding: EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                /*Container(
                  child: Icon(Icons.add_shopping_cart,
                      size: 40, color: Colors.red.shade900),
                  height: 80,
                ),*/
                Stack(
                  alignment: Alignment.topRight,
                  children: <Widget>[
                    Icon(Icons.add_shopping_cart,
                        size: 40, color: Colors.red.shade900),
                    CircleAvatar(
                      radius: 10.0,
                      backgroundColor: Colors.deepOrange.shade400,
                      child: Text(
                        "0",
                        style: TextStyle(color: Colors.white, fontSize: 12.0),
                      ),
                    ),
                  ],
                ),
                Text(
                  "Parked Sales",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.red.shade900),
                )
              ],
            ),
          ),
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => SalesListScreen(),
            ),
          ),
        ),
        _buildTile(
            Colors.lightBlueAccent,
            Padding(
              padding: EdgeInsets.all(24.0),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Icon(Icons.device_hub,
                        size: 40,
                        color: Colors
                            .pinkAccent), //Image.asset("assets/images/truck.png"),
                    height: 80,
                    //width: MediaQuery.of(context).size.width,
                  ),
                  Text(
                    "Deliveries",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.redAccent),
                  )
                ],
              ),
            ),
            onTap: () {}),
      ],
      staggeredTiles: [
        StaggeredTile.extent(1, 150.0),
        StaggeredTile.extent(1, 220.0),
        StaggeredTile.extent(1, 150.0),
        StaggeredTile.extent(1, 250.0),
        StaggeredTile.extent(1, 150.0),
      ],
    );
  }

  Widget _buildTile(color, Widget child, {Function() onTap}) {
    return Material(
      elevation: 14.0,
      borderRadius: BorderRadius.circular(12.0),
      shadowColor: Color(0x802196F3),
      color: color,
      child: InkWell(
          onTap: onTap != null
              ? () => onTap()
              : () {
                  print('Not set yet');
                },
          child: child),
    );
  }
}
