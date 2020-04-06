import 'package:flutter/material.dart';
import 'package:tengesa/ui/home_screen/home_screen.dart';
import 'package:tengesa/ui/login_screen/login_screen.dart';

class NavigationDrawer extends StatelessWidget{

  NavigationDrawer() : super();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          new DrawerHeader(
            child: new UserAccountsDrawerHeader(
              accountName: new Text(
                'Tengesa iPOS',
                style: TextStyle(color: Colors.green, fontSize: 20),
              ),
              accountEmail: new Text(
                'example@email.com',
                style: TextStyle(color: Colors.green),
              ),
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new ExactAssetImage('assets/images/wallpaper.jpeg'),
                  fit: BoxFit.cover,
                ),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://randomuser.me/api/portraits/men/46.jpg"),
              ),
            ),
          ),
          //decoration: new BoxDecoration(color: Colors.red),

          ListTile(
            leading: Icon(Icons.info),
            title: Text('My Page'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.hotel),
            title: Text('Manage Shop'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return HomeScreen();
                  },
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.shopping_basket),
            title: Text('Settings'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.mic),
            title: Text('Sign Out'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return LoginScreen();
                  },
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.mic),
            title: Text('About'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}