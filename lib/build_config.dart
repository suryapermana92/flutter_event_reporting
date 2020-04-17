
import 'dart:convert';
import 'package:flutter/services.dart';

abstract class BuildConfig {
  static Map<String, dynamic> _config;

  static Future<void> initialize({String env}) async {
    switch(env) {
      case Environment.PROD:
        final envJson = await rootBundle.loadString("config/prod/environment.json");
        _config = json.decode(envJson) as Map<String, dynamic>;
        break;
      case Environment.DEV:
      default:
        final envJson = await rootBundle.loadString("config/dev/environment.json");
        _config = json.decode(envJson) as Map<String, dynamic>;
    }
  }

  static String get env => _config["env"] as String;
  static String get HOST => _config["HOST"] as String;
}

abstract class Environment {
  static const DEV = 'DEV';
  static const PROD = 'PROD';
}