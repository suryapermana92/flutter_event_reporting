import 'package:flutter/material.dart';

Widget ProductListItem({String title, Function onPressed}) {
  return (
    Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Text(title),
          Padding(
            padding: const EdgeInsets.only(left: 18, right: 18),
          ),
          RaisedButton(
            onPressed: onPressed,
            child: Text('Apply'),
            elevation: 8
          )
        ],
      ),
    )
  );
}

Widget MyAppBar({String title}) => AppBar(title: Text(title));