import 'package:flutter/material.dart';
import 'package:tengesa/utils/strings.dart';

class NavigationDrawer extends StatelessWidget {
  NavigationDrawer() : super();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: new Text(Strings.appName),
              accountEmail: null,
              currentAccountPicture: CircleAvatar(
                child: Icon(Icons.beach_access,
                    color: Colors.redAccent,
                    size: 30), //Image.asset("assets/images/logo.png"),
                backgroundColor: Colors.white,
              ),
            ),
            Column(
              children: <Widget>[
                ListTile(
                  leading: new Icon(Icons.account_box,
                      color: Theme.of(context).accentColor),
                  title: new Text("Account"),
                  onTap: () {
                    Navigator.of(context).pop();
                    /*Navigator.of(context)
                              .push(new MaterialPageRoute(builder: (context) {
                            return Settings();
                          }));*/
                  },
                ),
                ListTile(
                  leading: new Icon(Icons.settings,
                      color: Theme.of(context).accentColor),
                  title: new Text("Settings"),
                  onTap: () {
                    Navigator.of(context).pop();
                    /*Navigator.of(context)
                              .push(new MaterialPageRoute(builder: (context) {
                            return Settings();
                          }));*/
                  },
                ),
                ListTile(
                  leading: new Icon(Icons.info,
                      color: Theme.of(context).accentColor),
                  title: new Text("About"),
                  onTap: () {
                    Navigator.of(context).pop();
                    /*Navigator.push(context,
                            new MaterialPageRoute(builder: (context) {
                              return new About();
                            }));*/
                  },
                ),
                Divider(
                  thickness: 2,
                ),
                ListTile(
                      leading: Icon(Icons.share,
                          color: Theme
                              .of(context)
                              .accentColor),
                      title: Text("Share"),
                      onTap: () {
                        //Share.share(
                        //    "Hey, checkout this cool music player at https://play.google.com/store/apps/details?id=com.onedreamers.musicplayer");
                        Navigator.of(context).pop();
                      },
                    ),
                    new ListTile(
                      leading: Icon(Icons.star,
                          color: Theme
                              .of(context)
                              .accentColor),
                      title: Text("Rate the app"),
                      onTap: () {
                        Navigator.of(context).pop();

                        //launchUrl(
                        //    "https://play.google.com/store/apps/details?id=com.onedreamers.musicplayer");
                      },
                    ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
