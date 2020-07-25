import 'package:fluttersismic/screens/login_screen/models/login_request.dart';
import 'package:fluttersismic/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

String api_base_url = Constants.api_base_url;

class login_service {
  static Future<http.Response> login(LoginFormData loginFormData) async {
    var url = "$api_base_url/1/users/login";
    Map<String, dynamic> body = {
//      "User ID": "qqq@qq.com",
      "username": '${loginFormData.username}',
      "password": '${loginFormData.password}',
    };

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    http.Response response;
    await http.post(url, body: json.encode(body), headers: headers).then((res) {
      response = res;
    }).catchError((err) {});

    return response;
  }
}
