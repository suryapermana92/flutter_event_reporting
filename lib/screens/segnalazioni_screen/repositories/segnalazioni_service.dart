import 'package:fluttersismic/global/services/auth.dart';
import 'package:fluttersismic/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

String api_base_url = Constants.api_base_url;

class SegnalazioniService {
  Future<http.Response> getSegnalazioniList() async {
    String accessToken = await authenticationService.getCurrentUser();

    var url = "$api_base_url/1/segnalazioni";
    Map<String, String> headers = {
      'Authorization': 'Bearer $accessToken',
      'Accept': 'application/json',
    };
    final response = await http.get(url, headers: headers);
    return response;
  }
}

SegnalazioniService segnalazioniService = SegnalazioniService();
