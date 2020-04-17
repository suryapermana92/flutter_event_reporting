

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:ui_hlb_ekyc_mobile/app_widget.dart';
import 'package:ui_hlb_ekyc_mobile/build_config.dart';
import 'package:ui_hlb_ekyc_mobile/simple_bloc_delegate.dart';

Future<void> mainCommon({@required String env}) async {
  WidgetsFlutterBinding.ensureInitialized();
  // initialize config for corresponding environment
  await BuildConfig.initialize(env: env);
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(App());
}