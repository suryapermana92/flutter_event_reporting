import 'package:flutter/material.dart';
import 'package:fluttersismic/styles/theme.dart';

class FullButton extends StatefulWidget {
  final Widget child;
  final onPressed;
  final Color color;
  final Color borderColor;
  final bool disabled;
  final double width;

  @override
  FullButton(
      {Key key,
      this.onPressed,
      this.disabled = false,
      @required this.child,
      this.color = ThemeColors.darkBlue,
      this.borderColor = ThemeColors.darkBlue,
      this.width})
      : super(key: key);

  @override
  _FullButtonState createState() => _FullButtonState();
}

class _FullButtonState extends State<FullButton> {
  Color beginColor;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: RaisedButton(
        onPressed: widget.disabled ? null : widget.onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(10.0),
        ),
        elevation: 2,
        padding: EdgeInsets.all(0),
        child: AnimatedContainer(
          height: 45,
          width: widget.width,
          duration: Duration(milliseconds: 300),
          decoration: BoxDecoration(
              color: widget.disabled ? Colors.grey : widget.color,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              border: Border.all(
                  color: widget.borderColor,
                  style:
                      widget.disabled ? BorderStyle.none : BorderStyle.solid)),
          child: widget.child,
        ),
      ),
    );
    ;
  }
}
