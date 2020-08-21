import 'package:flutter/material.dart';
import 'package:tengesa/utils/colors.dart';

class StocksHomeScreen extends StatefulWidget {
  @override
  _StocksHomeScreenState createState() => _StocksHomeScreenState();
}

class _StocksHomeScreenState extends State<StocksHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "View Shop Stocks",
                  style: TextStyle(
                      fontFamily: "HelveticaNeue",
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryColor),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Top Sellers",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: "HelveticaNeue",
                fontSize: 14,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            //ListView() //Put list of current stocks of current top sellers
          ],
        ),
      ),
    );
  }
}
