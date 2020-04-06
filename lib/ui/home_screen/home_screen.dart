import 'package:flutter/material.dart';
import 'package:tengesa/ui/home_screen/balance_card.dart';
import 'package:tengesa/ui/sale_screen/sale_screen.dart';
import 'package:tengesa/ui/shared/appbar.dart';
import 'package:tengesa/ui/shared/bottom_navigator.dart';
import 'package:tengesa/ui/shared/home_background.dart';
import 'package:tengesa/ui/shared/navigation_drawer.dart';
import 'package:tengesa/utils/strings.dart';

import 'dashboard_menu_row.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  Size deviceSize;

  DateTime currentBackPressTime = DateTime.now();

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (now.difference(currentBackPressTime) > Duration(seconds: 4)) {
      currentBackPressTime = now;
      final snackBar = SnackBar(content: Text(Strings.willPopAlert));
      _scaffoldkey.currentState.showSnackBar(snackBar);
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        key: _scaffoldkey,
        appBar: MyAppBar.getAppBar(context),
        drawer: NavigationDrawer(),
        body: _body(),
        bottomNavigationBar: BottomNavigator(),
        floatingActionButton: FloatingActionButton(
          onPressed: null,
          tooltip: 'New Sale',
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  Widget actionMenuCard() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Card(
          elevation: 2.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  DashboardMenuRow(
                    firstIcon: Icons.shop,
                    firstLabel: "Sale",
                    firstIconCircleColor: Colors.blue,
                    secondIcon: Icons.report,
                    secondLabel: "Look Up",
                    secondIconCircleColor: Colors.orange,
                    thirdIcon: Icons.store_mall_directory,
                    thirdLabel: "Exchanges",
                    thirdIconCircleColor: Colors.purple,
                    fourthIcon: Icons.tablet,
                    fourthLabel: "My Shop",
                    fourthIconCircleColor: Colors.indigo,
                  ),
                  DashboardMenuRow(
                    firstIcon: Icons.polymer,
                    firstLabel: "Status",
                    firstIconCircleColor: Colors.cyan,
                    secondIcon: Icons.phone,
                    secondLabel: "End Day",
                    secondIconCircleColor: Colors.redAccent,
                    thirdIcon: Icons.message,
                    thirdLabel: "Previous",
                    thirdIconCircleColor: Colors.pink,
                    fourthIcon: Icons.room,
                    fourthLabel: "Stock",
                    fourthIconCircleColor: Colors.brown,
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  Widget balanceCard(currency, pillText, pillColor, amount) => Padding(
        padding: const EdgeInsets.all(4.0),
        child: Card(
          elevation: 2.0,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      currency,
                      style: TextStyle(fontFamily: 'Raleway'),
                    ),
                    Material(
                      color: Colors.deepPurple,
                      shape: StadiumBorder(),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          pillText,
                          style: TextStyle(
                              color: pillColor, fontFamily: 'Raleway'),
                        ),
                      ),
                    )
                  ],
                ),
                Text(
                  amount,
                  style: TextStyle(
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.w700,
                      color: Colors.green,
                      fontSize: 20.0),
                ),
              ],
            ),
          ),
        ),
      );

  Widget allCards(BuildContext context) => SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height *
                  0.01, //deviceSize.height * 0.01,
            ),
            actionMenuCard(),
            SizedBox(
              height: MediaQuery.of(context).size.height *
                  0.01, //deviceSize.height * 0.01,
            ),
            balanceCard("US Dollar", "USD", Colors.white, "USD 15"),
            balanceCard("Bond Notes", "Bond", Colors.white, "RTGS\$ 77"),
            balanceCard("Ecocash", "Ecocash", Colors.white, "RTGS\$ 4700"),
            //balanceCard(),
            //balanceCard(),
          ],
        ),
      );

  Widget _body() {
    return Center(
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          HomeBackground(
            showIcon: false,
          ),
          allCards(context),
        ],
      ),
    );
  }

  
}
