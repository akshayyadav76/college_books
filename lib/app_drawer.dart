import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
    Drawer(
        child: ListView(

      children: <Widget>[
        UserAccountsDrawerHeader(
          accountName: Text("dsf"), accountEmail: Text("sdf"),),
        // Container(
        //   height: 40,
        //   width: 40,
        //   color: Colors.purple,
        // )
      ],
    ));
  }
}
