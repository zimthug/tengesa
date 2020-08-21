import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tengesa/model/sales.dart';
import 'package:tengesa/model/state/sales_state.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  Sales sales;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    sales = Provider.of<SalesStateModel>(context, listen: true).sale;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  Widget _body() {
    return Center(
      child: Text(
        "You must pay \$ " + sales.totalPrice.toStringAsFixed(2),
      ),
    );
  }
}
