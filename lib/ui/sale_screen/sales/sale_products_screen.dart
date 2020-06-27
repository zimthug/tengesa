import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:tengesa/model/currency.dart';
import 'package:tengesa/model/sales.dart';
import 'package:tengesa/model/state/sales_state.dart';
import 'package:tengesa/utils/colors.dart';

class SaleProductsScreen extends StatefulWidget {
  @override
  _SaleProductsScreenState createState() => _SaleProductsScreenState();
}

class _SaleProductsScreenState extends State<SaleProductsScreen> {
  Sales sales;
  int _currency;
  //double _totalPrice;
  List<SaleItems> saleItemsList;
  List<Currency> _currencyList = [];
  List<DropdownMenuItem> _currencyItems = [];

  @override
  void initState() {
    super.initState();
    _populateCurrenciesDropDownItems();
  }

  @override
  Widget build(BuildContext context) {
    sales =
        ScopedModel.of<SalesStateModel>(context, rebuildOnChange: true).sale;

    saleItemsList =
        ScopedModel.of<SalesStateModel>(context, rebuildOnChange: true)
            .saleItemsList;

    return Scaffold(
      body: sales == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              color: Colors.grey.shade300,
              child: body(),
            ),
    );
  }

  Widget body() {
    setState(() {
      if (_currency == null) {
        _currency = sales.currencyId;
		//_totalPrice = sales.totalPrice;
      }
    });

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Material(
              elevation: 4,
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                height: MediaQuery.of(context).size.height / 1.65,
                child: _saleItemsListing(),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Material(
              elevation: 4,
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              child: Container(
                height: 70,
                child: _invoiceBuilder(),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _saleItemsListing() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Currency",
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 12,
                ),
              ),
              SizedBox(
                width: 100,
                child: DropdownButton(
                  items: _currencyItems,
                  value: _currency,
                  isExpanded: true,
                  onChanged: (val) {
                    ScopedModel.of<SalesStateModel>(context)
                        .changeCurrency(val);
                    setState(() {
                      if (val != null) {
                        _currency = val;
                      }
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        Container(
            child: Expanded(
          child: ListView.builder(
              itemCount: ScopedModel.of<SalesStateModel>(context,
                      rebuildOnChange: true)
                  .saleItemsList
                  .length,
              itemBuilder: (context, index) {
                return ScopedModelDescendant<SalesStateModel>(
                    builder: (context, child, model) {
                  /*return ListTile(
                    title: Text(model.saleItemsList[index].product),
                    subtitle: Text(
                        "Unit Price ${model.saleItemsList[index].unitPrice.toStringAsFixed(2)}. Total Price ${model.saleItemsList[index].totalPrice.toStringAsFixed(2)}"),
                  );*/
                  return Card(
                    elevation: 8.0,
                    child: Container(
                      padding: EdgeInsets.all(5.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            ListTile(
                              title: Text(model.saleItemsList[index].product +
                                  " (" +
                                  model.saleItemsList[index].quantity
                                      .toString() +
                                  ")"),
                              subtitle: Text(
                                "Unit Price " +
                                    model.saleItemsList[index].unitPrice
                                        .toStringAsFixed(2) +
                                    " Total Price " +
                                    model.saleItemsList[index].totalPrice
                                        .toStringAsFixed(2),
                              ),
                            )
                          ]),
                    ),
                  );
                });
              }),
        ))
        /*
                ListView.builder(
                      itemCount: ScopedModel.of<SalesStateModel>(context,
                              rebuildOnChange: true)
                          .saleItemsList
                          .length,
                      itemBuilder: (context, index) {
                        return ScopedModelDescendant<SalesStateModel>(
                            builder: (context, child, model) {
                              return Container();
                          //return ListTile();
                        });
                      }),
                */
      ],
    );
  }

  Widget _invoiceBuilder() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        ListTile(
          title: Card(
            elevation: 8,
            color: Colors.grey.shade100,
            child: Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 80,
                    child: Text(
                      _currencyList
                          .firstWhere(
                            (cur) => cur.currencyId == sales.currencyId,
                            orElse: () => Currency(0, "NAN", "", ""),
                          )
                          .currency,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Container(
                    width: 150,
                    child: Text(
                        //"\$ ${sale.totalPrice.toStringAsFixed(2)}",
						sales.totalPrice.toStringAsFixed(2),
					    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          trailing: Container(
            height: 50,
            child: IconButton(
                icon: Icon(
                  FontAwesomeIcons.chevronCircleRight,
                  size: 35,
                  color: AppColors.primaryColor,
                ),
                onPressed: null),
          ),
        ),
      ],
    );
  }

  _populateCurrenciesDropDownItems() {
    /*ScopedModelDescendant<SalesStateModel>(
      builder: (context, child, model) => model.getCurrencyData()
    );*/

    ScopedModel.of<SalesStateModel>(context).getCurrencyData().then((value) {
      _currencyList = value;
      value.forEach((val) {
        setState(() {
          _currencyItems.add(
            DropdownMenuItem(
              child: Text(
                val.currency,
                style: TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w200,
                    fontSize: 12.0),
              ),
              value: val.currencyId,
            ),
          );
        });
      });
    });
  }
}
