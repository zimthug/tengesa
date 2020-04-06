import 'package:flutter/material.dart';
import 'package:tengesa/ui/home_screen/home_screen.dart';

class BottomNavigator extends StatefulWidget {
  @override
  _BottomNavigatorState createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  GlobalKey bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    int currentTabIndex = 0;
    List<Widget> tabs = [
      HomeScreen(),
      HomeScreen(),
      HomeScreen(),
    ];
    onTapped(int index) {
      setState(() {
        currentTabIndex = index;
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => tabs[currentTabIndex]));
      });
    }

    return BottomNavigationBar(
      onTap: onTapped,
      currentIndex: currentTabIndex,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: Colors.redAccent,
          ),
          title: Text(
            "Home",
            style: TextStyle(
                fontWeight: FontWeight.w700, color: Colors.blueAccent),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.shop,
            color: Colors.greenAccent,
          ),
          title: Text(
            "Stock",
            style:
                TextStyle(fontWeight: FontWeight.w700, color: Colors.redAccent),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.table_chart,
            color: Colors.orangeAccent,
          ),
          title: Text(
            "Report",
            style: TextStyle(fontWeight: FontWeight.w700, color: Colors.greenAccent),
          ),
        ),
      ],
    );
  }
}
