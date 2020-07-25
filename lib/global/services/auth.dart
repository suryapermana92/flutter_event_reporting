import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttersismic/screens/login_screen/models/login_request.dart';
import 'package:fluttersismic/screens/login_screen/repositories/login_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class AuthenticationService {
  static var storage = new FlutterSecureStorage();
  static Future<http.Response> signInWithEmailAndPassword(
      LoginFormData loginFormData) async {
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
    }).catchError((err) {
      print(err);
    });

    return response;
  }

  static Future<String> getCurrentUser() async {
    var accessToken;
    await storage
        .read(key: "accessToken")
        .then((value) => {accessToken = value});

    return accessToken;
  }

  static Future<String> saveCurrentUser(String accessToken) async {
    await storage.write(key: "accessToken", value: accessToken);

    return accessToken;
  }

  static Future<String> signOut() async {
    await storage.delete(key: "accessToken");
    print('access_token removed');
  }
}

AuthenticationService authenticationService = AuthenticationService();
