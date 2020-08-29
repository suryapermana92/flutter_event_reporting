import 'package:fluttersismic/models/User.dart';
import 'dart:convert';

class JwtService {
  static Map<String, dynamic> parseJwtPayload(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }
    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }

    return payloadMap;
  }

  static Map<String, dynamic> parseJwtHeader(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }

    final payload = _decodeBase64(parts[0]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }

    return payloadMap;
  }

  static String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');

    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!"');
    }

    return utf8.decode(base64Url.decode(output));
  }

  static bool isExpired(String token) {
    try {
      // Decode the token
      final Map<String, dynamic> decodedToken = parseJwtPayload(token);
      if (decodedToken != null) {
        // Get the expiration date
        final DateTime expirationDate =
            new DateTime.fromMillisecondsSinceEpoch(0)
                .add(new Duration(seconds: decodedToken["exp"]));
        // If the current date is after the expiration date, the token is already expired
        return new DateTime.now().isAfter(expirationDate);
      } else {
        return true;
      }
    } catch (error) {
      print(error);
      return true;
    }
  }
}
