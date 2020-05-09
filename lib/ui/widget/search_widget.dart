import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  final String searchbarText;
  SearchWidget({@required this.searchbarText});

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade200, //Color(0xFFF5F5F7),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        children: <Widget>[
          Icon(Icons.search),
          SizedBox(width: 16),
          Text(
            widget.searchbarText,
            style: TextStyle(
              fontSize: 18,
              color: Color(0xFFA0A5BD),
            ),
          )
        ],
      ),
    );
  }
}
