import 'dart:io';
import 'dart:math';

//import 'package:device_info/device_info.dart';
//import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttersismic/global/bloc/authentication/authentication_bloc.dart';
import 'package:fluttersismic/global/bloc/authentication/bloc.dart';
//import 'package:gooddriver/service/route_generator.dart';
//import 'package:gooddriver/service/auth.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttersismic/styles/theme.dart';
import 'package:fluttersismic/utils/route_generator.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}

class _SplashScreenState extends State<SplashScreen> {
//  FirebaseAnalytics analytics = new FirebaseAnalytics();
//  final _auth = new Auth();
  String _userId;
  @override
  void initState() {
    super.initState();
//    _getDeviceId();
//    _auth.getCurrentUser().then((user) {
//      setState(() {
//        if (user != null) {
//          _userId = user?.uid;
//        }
//        user?.uid == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN;
//      });
//    });

    _preLogin() {
      authenticationBloc.add(AppLoaded());
    }

    Future.delayed(Duration(seconds: 3), () async {
      _preLogin();
    });
  }

  _disableAutoSignout() async {
//    final prefs = await SharedPreferences.getInstance();
    final key = 'hasSignOutAfterReinstall';
//    prefs.setBool(key, true);
//    print('saved $key true');
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: BlocListener<AuthenticationBloc, AuthenticationState>(
        bloc: authenticationBloc,
        listener: (context, state) {
          if (state is AuthenticationAuthenticated) {
            Navigator.of(context).pushReplacementNamed(dashboardScreen);
          } else if (state is AuthenticationNotAuthenticated) {
            Navigator.of(context).pushReplacementNamed(loginScreen);
          }
        },
        child: Container(
          child: Center(
            child: Image(
                width: 170.0,
                height: 130.0,
                fit: BoxFit.contain,
                image: new AssetImage('assets/images/logo-placeholder.png')),
          ),
          decoration: BoxDecoration(
            gradient: new LinearGradient(
                colors: [ThemeColors.lightGrey, ThemeColors.mediumGrey],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
//        color: ThemeColors.backgroundBlue,
        ),
      ),
    ));
  }
}
