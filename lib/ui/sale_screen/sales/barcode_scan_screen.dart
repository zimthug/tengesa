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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(height: 130, color: Colors.blueGrey),
        Container(height: 130),
        Container(height: 130, color: Colors.blueGrey),
      ],
    );
  }
}
