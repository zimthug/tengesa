import 'package:flutter/material.dart';
import 'package:tengesa/ui/reports_screen/reports_home_screen.dart';
import 'package:tengesa/ui/sale_screen/sales_home_screen.dart';
import 'package:tengesa/ui/shared/appbar.dart';
import 'package:tengesa/ui/home_screen/home_screen.dart';
import 'package:tengesa/ui/shared/navigation_drawer.dart';
import 'package:tengesa/ui/stocks_screen/stocks_main_screen.dart';
import 'package:tengesa/utils/colors.dart';
import 'package:tengesa/utils/strings.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

PageController pageController;

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin<MainScreen> {
  int _page = 0;
  DateTime currentBackPressTime = DateTime.now();
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  Future<bool> _onWillPop() {
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
      onWillPop: _onWillPop,
      child: Scaffold(
          key: _scaffoldkey,
          //appBar: MyAppBar.getAppBar(context),
          drawer: NavigationDrawer(),
          body: PageView(
            children: [
              Container(
                color: Colors.white,
                child: HomeScreen(),
              ),
              Container(
                  color: Colors.white,
                  //child: SaleScreen(),
                  child: SalesHomeScreen()),
              Container(
                color: Colors.white,
                //child: StocksScreen(),
                child: StocksMainScreen(),
              ),
              Container(
                color: Colors.white,
                child: ReportHomeScreen(),
              ),
            ],
            controller: pageController,
            physics: NeverScrollableScrollPhysics(),
            onPageChanged: onPageChanged,
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.home,
                      color:
                          (_page == 0) ? AppColors.primaryColor : Colors.grey),
                  title: Container(height: 0.0),
                  backgroundColor: Colors.white),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_basket,
                      color:
                          (_page == 1) ? AppColors.primaryColor : Colors.grey),
                  title: Container(height: 0.0),
                  backgroundColor: Colors.white),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shop,
                      color:
                          (_page == 2) ? AppColors.primaryColor : Colors.grey),
                  title: Container(height: 0.0),
                  backgroundColor: Colors.white),
              BottomNavigationBarItem(
                  icon: Icon(Icons.table_chart,
                      color:
                          (_page == 3) ? AppColors.primaryColor : Colors.grey),
                  title: Container(height: 0.0),
                  backgroundColor: Colors.white),
            ],
            onTap: navigationTapped,
            currentIndex: _page,
          ),
          floatingActionButton: _page == 0
              ? FloatingActionButton(
                  onPressed: () async {
                    //pageController.jumpToPage(1);
                    navigationTapped(1);
                  },
                  child: Icon(Icons.shopping_cart),
                )
              : null),
    );
  }

  void navigationTapped(int page) {
    //Animating Page
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(
      () {
        this._page = page;
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }
}
