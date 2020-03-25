import 'package:flutter/material.dart';

class BottomBarScreen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[

            IconButton(
                icon: Icon(Icons.drag_handle),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                }),
            Expanded(
              child: RaisedButton(
                child: Text(
                  "College Books",
                  style: Theme.of(context).textTheme.title,
                ),
                onPressed: (){},
              ),
            ),
            IconButton(icon: Icon(Icons.filter_list), onPressed: () {})
          ],
        ),
      ],
    );
  }
}
