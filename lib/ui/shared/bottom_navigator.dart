import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tengesa/ui/home_screen/home_screen.dart';
import 'package:tengesa/ui/reports_screen/reports_home_screen.dart';
import 'package:tengesa/ui/sale_screen/sale_screen.dart';
import 'package:tengesa/ui/stocks_screen/stocks_screen.dart';
import 'package:tengesa/utils/strings.dart';

class BottomNavigator extends StatefulWidget {
  @override
  _BottomNavigatorState createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  GlobalKey bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    int currentTabIndex = 0;
    List<Widget> tabs = [
      HomeScreen(),
      SaleScreen(),
      StocksScreen(),
      ReportHomeScreen(),
    ];
    onTapped(int index) {
      setState(() {
        currentTabIndex = index;
        //Navigator.pop(context);
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => tabs[currentTabIndex]));
      });
    }

    /*return CupertinoTabBar*/
    return BottomNavigationBar(      
      onTap: onTapped,
      currentIndex: currentTabIndex,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: Colors.blue,
          ),
          title: Text(Strings.bnbhome), //new Container(height: 0.0),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.shopping_basket,
            color: Colors.blue,
          ),
          title: Text(Strings.bnbsale), //new Container(height: 0.0),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.shop,
            color: Colors.blue,
          ),
          title: Text(Strings.bnbstocks), //new Container(height: 0.0),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.table_chart,
            color: Colors.blue,
          ),
          title: Text(Strings.bnbreports), //new Container(height: 0.0),
        ),
      ],
    );
  }
}
