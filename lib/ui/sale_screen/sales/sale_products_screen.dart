import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:tengesa/model/currency.dart';
import 'package:tengesa/model/sales.dart';
import 'package:tengesa/model/state/sales_state.dart';
import 'package:tengesa/utils/colors.dart';
import 'package:tengesa/utils/database/db_manager.dart';

class SaleProductsScreen extends StatefulWidget {
  @override
  _SaleProductsScreenState createState() => _SaleProductsScreenState();
}

class _SaleProductsScreenState extends State<SaleProductsScreen> {
  int _currency;
  Sales sales;
  List<Currency> _currencyList = [];
  DbManager db = DbManager();
  List<SaleItems> saleItemsList;
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
              child: _body(),
            ),
    );
  }

  Widget _body() {
    setState(() {
      if (_currency == null) {
        _currency = sales.currencyId;
      }
    });

    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Material(
              elevation: 4,
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
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
                height: 100,
                child: _invoiceBuilder(),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _invoiceBuilder() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Total",
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Divider(
          height: 2,
          color: Colors.black87,
        ),
        ListTile(
          contentPadding: const EdgeInsets.only(
            left: 10,
            top: 5,
            bottom: 5,
          ),
          leading: Card(
            elevation: 4,
            child: Container(
              width: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Currency",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    _currencyList
                        .firstWhere((cur) => cur.currencyId == _currency,
                            orElse: () => Currency(0, "NAN", "", ""))
                        .currency,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[              
              Text(
                "Sale Total",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),            
              Text(
                sales.totalPrice.toStringAsFixed(2),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.italic),
              ),
            ],
          ),
          trailing: Container(
            height: 70,
            width: 80,
            padding: const EdgeInsets.only(right: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconButton(
                    icon: Icon(
                      FontAwesomeIcons.chevronCircleRight,
                      size: 36,
                      color: AppColors.primaryColor,
                    ),
                    onPressed: null),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _saleItemsListing() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Basket List Items",
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 100,
                child: DropdownButton(
                  items: _currencyItems,
                  value: _currency,
                  isExpanded: true,
                  onChanged: (val) {
                    ScopedModel.of<SalesStateModel>(context).changeCurrency(val);
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
        Divider(
          height: 3,
          color: Colors.black87,
        ),
        Text(saleItemsList.length.toString()),
      ],
    );
  }

  _populateCurrenciesDropDownItems() {
    db.getCurrencyData().then((value) {
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
