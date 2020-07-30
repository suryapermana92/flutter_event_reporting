import 'package:flutter/material.dart';
import 'package:fluttersismic/screens/add_segnalazioni_screen/add_segnalazioni_screen.dart';
import 'package:fluttersismic/screens/dashboard_screen/screens/dashboard_screen.dart';
import 'package:fluttersismic/screens/login_screen/screens/login_screen.dart';
import 'package:fluttersismic/screens/segnalazioni_screen/segnalazioni_screen.dart';
import 'package:fluttersismic/screens/splash_screen/splash_screen.dart';
//import 'package:good_driver_app/screens/EmergencyPage.dart';

const indexRoute = '/';
const dashboardScreen = '/dashboard_screen';
const loginScreen = '/login_screen';
const addSegnalazioniScreen = '/add_segnalazioni_screen';
const segnalazioniScreen = '/segnalazioni_screen';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case indexRoute:
        return MaterialPageRoute(
            builder: (_) => SplashScreen(),
            settings: RouteSettings(name: "splash_screen"));
      case loginScreen:
        return MaterialPageRoute(
            builder: (_) => LoginScreen(),
            settings: RouteSettings(name: "login_screen"));
      case dashboardScreen:
        return MaterialPageRoute(
            builder: (_) => DashboardScreen(),
            settings: RouteSettings(name: "dashboard_screen"));
//      case addSegnalazioniScreen:
//        return MaterialPageRoute(
//            builder: (_) => AddSegnalazioniScreen(),
//            settings: RouteSettings(name: "add_segnalazioni_screen"));
      case segnalazioniScreen:
        return MaterialPageRoute(
            builder: (_) => SegnalazioniScreen(),
            settings: RouteSettings(name: "add_segnalazioni_screen"));

//      case parkingDetailRoute:
//        return MaterialPageRoute(
//            settings: RouteSettings(name: parkingDetailRoute),
//            builder: (_) => ParkingDetailScreen(data: settings.arguments));
//      case parkingWriteReviewRoute:
//        return MaterialPageRoute(
//            settings: RouteSettings(name: parkingWriteReviewRoute),
//            builder: (_) => ParkingWriteReviewScreen(
//                  placeId: settings.arguments,
//                ));
//
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(child: Text('ERROR 404')),
      );
    });
  }
}
