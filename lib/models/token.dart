// To parse this JSON data, do
//
//     final token = tokenFromJson(jsonString);

import 'dart:convert';

Token tokenFromJson(String str) => Token.fromJson(json.decode(str));

String tokenToJson(Token data) => json.encode(data.toJson());

class Token {
  Token({
    this.token,
  });

  final String token;

  Token copyWith({
    String token,
  }) =>
      Token(
        token: token ?? this.token,
      );

  factory Token.fromJson(Map<String, dynamic> json) => Token(
        token: json["token"] == null ? null : json["token"],
      );

  Map<String, dynamic> toJson() => {
        "token": token == null ? null : token,
      };
}
