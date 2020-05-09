import 'package:flutter/material.dart';
import 'package:tengesa/ui/shared/appbar.dart';
import 'package:tengesa/ui/widget/search_widget.dart';
import 'package:tengesa/utils/colors.dart';

class MakeSaleScreen extends StatefulWidget {
  @override
  _MakeSaleScreenState createState() => _MakeSaleScreenState();
}

class _MakeSaleScreenState extends State<MakeSaleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar.getAppBar(context),
      //drawer: NavigationDrawer(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 40, 10, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Find a sale to continue",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              Icon(Icons.refresh, color: Colors.deepOrange)
            ],
          ),
          SearchWidget(searchbarText: "Search..."),
          SizedBox(height: 60),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.white,
              ),
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[],
                    ),
                  ),
                  Positioned(
                    right: 0,
                    left: 0,
                    bottom: 0,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      height: 80,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 4),
                            blurRadius: 50,
                            color: AppColors.primaryColor //.withOpacity(.1),
                          ),
                        ],
                      ),
                      child: Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.all(8),
                              height: 46,
                              width: 80,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Icon(Icons.shopping_basket, color: Colors.deepOrange,),
                            ),
                          ),
                          SizedBox(width: 30),
                          Expanded(
                            child: GestureDetector(
                              child: Container(
                                alignment: Alignment.center,
                                height: 46,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  color: AppColors.primaryColor,
                                ),
                                child: Text(
                                  "New Sale",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              onTap: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
