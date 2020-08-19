import 'package:flutter/material.dart';
import 'package:fluttersismic/styles/theme.dart';

PreferredSizeWidget TransparentAppBar(context, title) {
  return new AppBar(
    elevation: 0.0,
    brightness: Brightness.light,
    title: Text(title),
    leading: new IconButton(
      icon: new Icon(
        Icons.chevron_left,
        color: ThemeColors.darkBlue,
        size: 30,
      ),
      onPressed: () => Navigator.of(context).pop(),
    ),
//    backgroundColor: Colors.transparent,
    backgroundColor: ThemeColors.backgroundColor,
    textTheme: TextTheme(
      headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
      title: TextStyle(
          fontSize: 18.0,
          color: ThemeColors.darkBlue,
          fontWeight: FontWeight.w600),
      body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
    ),
  );
}

class AppBarComponent extends StatefulWidget implements PreferredSizeWidget {
  final BuildContext context;
  final String title;
  final scaffoldKey;
  final bool goBack;

  @override
  AppBarComponent(
      {Key key,
      this.title = '',
      this.goBack = true,
      @required this.context,
      this.scaffoldKey})
      : super(key: key);

  @override
  _AppBarComponentState createState() => _AppBarComponentState();

  @override
  Size get preferredSize {
    return new Size.fromHeight(60.0);
  }
}

class _AppBarComponentState extends State<AppBarComponent> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      brightness: Brightness.light,
      title: Center(
          child: Text(
        widget.title,
        style: TextStyle(
            fontSize: 16,
            fontFamily: sourceSansPro,
            fontWeight: FontWeight.normal,
            color: ThemeColors.darkBlue),
      )),
      leading: widget.goBack
          ? new IconButton(
              icon: new Icon(
                Icons.chevron_left,
                color: ThemeColors.darkBlue,
                size: 30,
              ),
              onPressed: () => Navigator.of(context).pop(),
            )
          : IconButton(
              onPressed: () {
                widget.scaffoldKey.currentState.openDrawer();
              },
              icon: new Tab(
                icon: Container(
                  color: Colors.transparent,
                  height: 22,
                  width: 22,
                  child: Center(
                    child: new Image.asset(
                        "assets/drawable-xxxhdpi/hamburger.png",
                        fit: BoxFit.contain),
                  ),
                ),
              ),
            ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: IconButton(
            onPressed: () {
//              Navigator.of(context).pushNamed(notificationsScreen);
            },
            icon: Tab(
              icon: new Container(
                  height: 60,
                  width: 60,
//          color: Colors.red,
                  child: Center(child: SizedBox()
//                    new Image.asset(
//                        "assets/drawable-xxxhdpi/notifications_alert_edit.png",
//                        width: 50,
//                        height: 35),
                      )),
            ),
          ),
        )
      ],
//    backgroundColor: Colors.transparent,
      backgroundColor: ThemeColors.backgroundColor,
      textTheme: TextTheme(
        headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
        title: TextStyle(
            fontSize: 18.0,
            color: ThemeColors.darkBlue,
            fontWeight: FontWeight.w600),
        body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
      ),
    );
  }
}

PreferredSizeWidget MainAppBar(context, title, goBack, scaffoldKey) {
  return new AppBar(
    elevation: 0.0,
    brightness: Brightness.dark,
    title: Center(
        child: Text(
      title,
      style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: ThemeColors.darkBlue),
    )),
    leading: goBack
        ? new IconButton(
            icon: new Icon(
              Icons.chevron_left,
              color: ThemeColors.darkBlue,
              size: 30,
            ),
            onPressed: () => Navigator.of(context).pop(),
          )
        : new Tab(
            icon: Material(
              child: InkWell(
                onTap: () {
                  scaffoldKey.currentState.openDrawer();
                },
                child: Container(
                  height: 22,
                  width: 22,
                  child: new Image.asset("assets/hamburger.png",
                      fit: BoxFit.contain),
                ),
              ),
            ),
          ),
    actions: <Widget>[
      IconButton(
        onPressed: () {},
        icon: Tab(
          child: new Container(
              padding: EdgeInsets.only(right: 8),
              height: 22,
              width: 22,
//          color: Colors.red,
              child: new Image.asset("assets/notifications_alert.png")),
        ),
      )
    ],
//    backgroundColor: Colors.transparent,
    backgroundColor: ThemeColors.backgroundColor,
    textTheme: TextTheme(
      headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
      title: TextStyle(
          fontSize: 18.0,
          color: ThemeColors.darkBlue,
          fontWeight: FontWeight.w600),
      body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
    ),
  );
}
