// To parse this JSON data, do
//
//     final loginFormData = loginFormDataFromJson(jsonString);

import 'dart:convert';

LoginFormData loginFormDataFromJson(String str) =>
    LoginFormData.fromJson(json.decode(str));

String loginFormDataToJson(LoginFormData data) => json.encode(data.toJson());

class LoginFormData {
  LoginFormData({
    this.username,
    this.password,
  });

  final String username;
  final String password;

  LoginFormData copyWith({
    String username,
    String password,
  }) =>
      LoginFormData(
        username: username ?? this.username,
        password: password ?? this.password,
      );

  factory LoginFormData.fromJson(Map<String, dynamic> json) => LoginFormData(
        username: json["username"] == null ? null : json["username"],
        password: json["password"] == null ? null : json["password"],
      );

  Map<String, dynamic> toJson() => {
        "username": username == null ? null : username,
        "password": password == null ? null : password,
      };
}
