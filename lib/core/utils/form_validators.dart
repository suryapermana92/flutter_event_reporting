import 'package:ui_hlb_ekyc_mobile/core/constants/app_constants.dart';
import 'package:meta/meta.dart';

bool isBlank({ @required String value }) => value?.trim()?.isEmpty;

bool isOnlyAlphabet({ @required String value }) =>
  RegExp(AppConstants.ONLY_ALPHABET_PATTERN).hasMatch(value);

bool isEmail({ @required String value }) =>
  RegExp(AppConstants.EMAIL_PATTERN).hasMatch(value);

bool isMobileNumber({ @required String value }) =>
  RegExp(AppConstants.MY_MOBILE_NUMBER_PATTERN).hasMatch(value);