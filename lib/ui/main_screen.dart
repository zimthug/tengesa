import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tengesa/ui/sale_screen/sale_screen.dart';
import 'package:tengesa/ui/shared/appbar.dart';
import 'package:tengesa/ui/home_screen/home_screen.dart';
import 'package:tengesa/ui/shared/bottom_navigator.dart';
import 'package:tengesa/ui/shared/navigation_drawer.dart';
import 'package:tengesa/utils/strings.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

PageController pageController;

class _MainScreenState extends State<MainScreen> {
  int _page = 0;

  DateTime currentBackPressTime = DateTime.now();
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

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
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        key: _scaffoldkey,
        appBar: MyAppBar.getAppBar(context),
        drawer: NavigationDrawer(),
        body: PageView(
          children: [
            Container(
              color: Colors.white,
              child: HomeScreen(),
            ),
            Container(
              color: Colors.white,
              child: SaleScreen(),
            ),
            Container(
              color: Colors.white,
              child: HomeScreen(),
            ),
            Container(
              color: Colors.white,
              child: HomeScreen(),
            ),
          ],
          controller: pageController,
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: onPageChanged,
        ),
        bottomNavigationBar: CupertinoTabBar(
          activeColor: Colors.orange,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home,
                    color: (_page == 0) ? Colors.black : Colors.grey),
                title: Container(height: 0.0),
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_basket,
                    color: (_page == 1) ? Colors.black : Colors.grey),
                title: Container(height: 0.0),
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
                icon: Icon(Icons.shop,
                    color: (_page == 2) ? Colors.black : Colors.grey),
                title: Container(height: 0.0),
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
                icon: Icon(Icons.table_chart,
                    color: (_page == 3) ? Colors.black : Colors.grey),
                title: Container(height: 0.0),
                backgroundColor: Colors.white),
          ],
          onTap: navigationTapped,
          currentIndex: _page,
        ),
      ),
    );
  }

  void navigationTapped(int page) {
    //Animating Page
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }
}
