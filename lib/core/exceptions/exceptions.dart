
import 'package:meta/meta.dart';

class UnAuthorizedException implements Exception {}

class BadRequestException implements Exception {}

class ServiceException implements Exception {
  const ServiceException({
    @required this.message,
    @required this.errorCode
  });

  final String message;
  final int errorCode;
}
