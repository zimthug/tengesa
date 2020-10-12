import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tengesa/utils/colors.dart';

class ProductsScreen extends StatefulWidget {
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Shop Stocks",
                  style: TextStyle(
                      fontFamily: "HelveticaNeue",
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryColor),
                ),
                SizedBox(
                  width: 10,
                ),
                IconButton(
                    icon: Icon(
                      FontAwesomeIcons.warehouse,
                      color: AppColors.primaryColor,
                      size: 24,
                    ),
                    onPressed: null),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "All Items",
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
