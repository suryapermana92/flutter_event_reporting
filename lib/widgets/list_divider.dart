import 'package:flutter/material.dart';

class ListDivider extends StatefulWidget {
  final double height;
  final double width;
  final margin;
  final color;
  @override
  ListDivider(
      {Key key,
      this.height = 1,
      this.width = double.infinity,
      this.color = const Color.fromRGBO(112, 112, 112, 0.3),
      this.margin = const EdgeInsets.only(left: 16)})
      : super(key: key);

  @override
  _ListDividerState createState() => _ListDividerState();
}

class _ListDividerState extends State<ListDivider> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      margin: widget.margin,
      color: widget.color,
    );
  }
}
