import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tengesa/model/state/cart_state.dart';
import 'package:tengesa/ui/sale_screen/sale_screen.dart';
import 'package:tengesa/utils/strings.dart';

class MyAppBar {
  static getAppBar(context) {
    //final cartCount = Provider.of<CartState>(context);
    final cartCount = CartState();
    final TextEditingController _searchControl = new TextEditingController();

    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.lightBlue,
      title: Text(
        Strings.appName,
        style: TextStyle(fontFamily: 'Raleway', fontSize: 20),
      ),      
      actions: <Widget>[
        new Padding(
          padding: const EdgeInsets.all(10.0),
          child: new Container(
            height: 150.0,
            width: 30.0,
            child: new GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  new MaterialPageRoute(
                      //builder: (BuildContext context) => new CartItems(),
                      builder: (BuildContext context) => new SaleScreen(),
                      ),
                );
              },
              child: new Stack(
                children: <Widget>[
                  new IconButton(
                    icon: new Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                    onPressed: null,
                  ),
                  cartCount.getCartCount == 0
                      ? new Container()
                      : new Positioned(
                          child: new Stack(
                            children: <Widget>[
                              new Icon(Icons.brightness_1,
                                  size: 20.0, color: Colors.green[800]),
                              new Positioned(
                                top: 3.0,
                                right: 4.0,
                                child: new Center(
                                  child: new Text(
                                    //cartList.length.toString(),
                                    //cartCount.getCartCount.toString(),
                                    "20",
                                    style: new TextStyle(
                                        color: Colors.white,
                                        fontSize: 11.0,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
