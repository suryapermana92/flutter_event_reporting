import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:ui_hlb_ekyc_mobile/router.gr.dart';
import 'package:ui_hlb_ekyc_mobile/simple_bloc_delegate.dart';

void main(){
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: Router.productsListPage,
      onGenerateRoute: Router.onGenerateRoute,
      navigatorKey: Router.navigatorKey,
    );
  }
}