import 'package:fluttersismic/global/services/auth.dart';
import 'package:fluttersismic/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

String api_base_url = Constants.api_base_url;

class DashboardService {
  Future<http.Response> getDashboardData() async {
    String accessToken = await authenticationService.getCurrentUser();

    var url = "$api_base_url/1/dashboard";
    Map<String, String> headers = {
      'Authorization': 'Bearer $accessToken',
      'Accept': 'application/json',
    };
    final response = await http.get(url, headers: headers);
    return response;
  }

  Future<http.Response> getSegnalazioniTipologia() async {
    String accessToken = await authenticationService.getCurrentUser();

    var url = "$api_base_url/1/tipologie_segnalazioni";
    Map<String, String> headers = {
      'Authorization': 'Bearer $accessToken',
      'Accept': 'application/json',
    };
    final response = await http.get(url, headers: headers);
    return response;
  }
}

DashboardService dashboardService = DashboardService();
