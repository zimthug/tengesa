import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
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
        children: <Widget>[_currencyCard()],
      ),
    );
  }

  Widget _currencyCard() {
    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        height: 50,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Change Currency ",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              SizedBox(
                width: 180,
                child: DropdownButton(
                  items: _currencyItems,
                  value: _currency,
                  isExpanded: true,
                  onChanged: (val) {
                    setState(() {
                      if (val != null) {
                        _currency = val;
                      }
                    });
                  },
                ),
              ),
            ]),
      ),
    );
  }

  _populateCurrenciesDropDownItems() {
    db.getCurrencyData().then((value) {
      value.forEach((val) {
        setState(() {
          _currencyItems.add(
            DropdownMenuItem(
              child: Text(
                val.currency,
                style: TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w800,
                    fontSize: 14.0),
              ),
              value: val.currencyId,
            ),
          );
        });
      });
    });
  }
}
