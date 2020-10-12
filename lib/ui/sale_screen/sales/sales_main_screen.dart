import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tengesa/ui/sale_screen/sales/barcode_scan_screen.dart';
import 'package:tengesa/ui/sale_screen/sales/payment_screen.dart';
import 'package:tengesa/ui/sale_screen/sales/sale_products_screen.dart';
import 'package:tengesa/ui/sale_screen/sales/search_products_screen.dart';
import 'package:tengesa/ui/shared/appbar.dart';
import 'package:tengesa/utils/colors.dart';

class SalesMainScreen extends StatefulWidget {
  @override
  _SalesMainScreenState createState() => _SalesMainScreenState();
}

PageController pageController;

class _SalesMainScreenState extends State<SalesMainScreen>
    with SingleTickerProviderStateMixin {
  int _page = 0;

  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: _scaffoldkey,
        appBar: MyAppBar.getAppBar(context),
        floatingActionButton: fab(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: saleBottomNavigationBar(),
        body: PageView(
          children: [
            Container(
                color: Colors.white,
                child: SaleProductsScreen(
                  onButtonPressed: () => pageController.animateToPage(
                    5,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.linear,
                  ),
                )),
            Container(
              color: Colors.white,
              //child: SaleScreen(),
              child: Container(
                child: BarcodeScanScreen(), //Text("Two"),
              ),
            ),
            Container(
              color: Colors.white,
              child: Container(
                child: SearchProductsScreen(
                  onButtonPressed: () => pageController.animateToPage(
                    0,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.linear,
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: Container(
                child: Text("Four"),
              ),
            ),
            Container(
              color: Colors.white,
              child: Container(
                child: Text("Five"),
              ),
            ),
            Container(
              color: Colors.white,
              child: Container(
                child: PaymentScreen(),
              ),
            ),
          ],
          controller: pageController,
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: onPageChanged,
        ),
      ),
    );
  }

  Future<bool> _onWillPop() {
    Navigator.of(context).pop();
    return Future.value(false);
  }

  Widget fab() {
    return Stack(
      alignment: Alignment.topLeft,
      children: <Widget>[
        FloatingActionButton(
          onPressed: () {
            navigationTapped(0);
          },
          child: Icon(Icons.shopping_cart),
        ),
        CircleAvatar(
          radius: 8.0,
          backgroundColor: Colors.red,
          child: Text(
            "0",
            style: TextStyle(color: Colors.white, fontSize: 12.0),
          ),
        )
      ],
    );
  }

  Widget saleBottomNavigationBar() {
    return BottomAppBar(
      color: AppColors.primaryColor,
      elevation: 0.0,
      shape: CircularNotchedRectangle(),
      notchMargin: 6.0,
      child: Container(
        height: 40.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            GestureDetector(
              child: Container(
                width: MediaQuery.of(context).size.width / 5,
                child: Icon(FontAwesomeIcons.barcode /*Icons.scanner*/,
                    size: 25.0, color: Colors.white),
              ),
              onTap: () {
                navigationTapped(1);
              },
            ),
            GestureDetector(
              child: Container(
                width: MediaQuery.of(context).size.width / 5,
                child: Icon(Icons.search, size: 25.0, color: Colors.white),
              ),
              onTap: () {
                navigationTapped(2);
              },
            ),
            Container(width: MediaQuery.of(context).size.width / 5),
            GestureDetector(
              child: Container(
                width: MediaQuery.of(context).size.width / 5,
                child: Icon(FontAwesomeIcons.clipboard /*Icons.note_add*/,
                    size: 25.0, color: Colors.white),
              ),
              onTap: () {
                navigationTapped(3);
              },
            ),
            GestureDetector(
              child: Container(
                width: MediaQuery.of(context).size.width / 5,
                child: Icon(Icons.close, size: 25.0, color: Colors.white),
              ),
              onTap: () {
                navigationTapped(4);
              },
            )
          ],
        ),
      ),
      //onTap: navigationTapped,
      //currentIndex: _page,
    );
  }

  void navigationTapped(int page) {
    //Animating Page
    //pageController.jumpToPage(page);
    pageController.animateToPage(page,
        duration: Duration(milliseconds: 500), curve: Curves.ease);
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
