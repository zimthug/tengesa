import 'package:flutter/material.dart';
import 'package:tengesa/model/sales_grid.dart';

class SalesGridListItem extends StatelessWidget {
  const SalesGridListItem(this._gridList);
  @required
  final SalesGrid _gridList;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      color: Colors.grey.shade100,
      child: Column(
        children: <Widget>[
          Container(
            child: Image.asset(_gridList.image),
            height: 80,
            width: MediaQuery.of(context).size.width / 2.2,
          ),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  _gridList.subject,
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
