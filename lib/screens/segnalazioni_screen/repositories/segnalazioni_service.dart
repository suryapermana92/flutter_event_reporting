import 'package:fluttersismic/global/services/auth.dart';
import 'package:fluttersismic/models/segnalazioni_response.dart';
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

  Future<http.Response> postSegnalazioni(Segnalazioni segnalazioniData) async {
    String accessToken = await authenticationService.getCurrentUser();

    var url = "$api_base_url/1/segnalazioni";
    Map<String, String> headers = {
      'Authorization': 'Bearer $accessToken',
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    Map<String, dynamic> body = segnalazioniData.toJson();
//    Map<String, dynamic> body = {
//      "richiedente_nominativo_nome": "Mario",
//      "richiedente_nominativo_cognome": "Rossi",
//      "richiedente_email": "sample@sample.it",
//      "richiedente_telefono": "123456",
//      "evento_indirizzo1": "via nazionale2222",
//      "evento_civico1": "10",
//      "evento_comune": "firenze",
//      "evento_ubicazione": "vicino bar",
//      "evento_coordinate_lat": 41.7,
//      "evento_coordinate_lon": 11.5,
//      "id_tipologie_segnalazioni": 1
//    };
    http.Response response;
    await http.post(url, body: json.encode(body), headers: headers).then((res) {
      response = res;
    }).catchError((err) {
      print(err);
    });
    return response;
  }

  Future<http.Response> updateSegnalazioni(
      {int id, Segnalazioni segnalazioniData}) async {
    String accessToken = await authenticationService.getCurrentUser();

    var url = "$api_base_url/1/segnalazioni/${id.toString()}";
    Map<String, String> headers = {
      'Authorization': 'Bearer $accessToken',
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    Map<String, dynamic> body = segnalazioniData.toJson();

    http.Response response;
    await http.put(url, body: json.encode(body), headers: headers).then((res) {
      response = res;
    }).catchError((err) {
      print(err);
    });
    return response;
  }

  Future<http.Response> deleteSegnalazioni(int id) async {
    String accessToken = await authenticationService.getCurrentUser();

    var url = "$api_base_url/1/segnalazioni/${id.toString()}";
    Map<String, String> headers = {
      'Authorization': 'Bearer $accessToken',
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
//    Map<String, dynamic> body = segnalazioniData.toJson();

    http.Response response;
    await http.delete(url, headers: headers).then((res) {
      response = res;
    }).catchError((err) {
      print(err);
    });
    return response;
  }
}

SegnalazioniService segnalazioniService = SegnalazioniService();
