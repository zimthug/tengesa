import 'package:flutter/material.dart';

class BarcodeScanScreen extends StatefulWidget {
  @override
  _BarcodeScanScreenState createState() => _BarcodeScanScreenState();
}

class _BarcodeScanScreenState extends State<BarcodeScanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  Widget _body() {
    return Center(
      child: Container(
        color: Colors.grey[300],
        width: MediaQuery.of(context).size.width * .9,
        height: 200,
      ),
    );
  }
}
