import 'dart:ui';

import 'package:flutter/cupertino.dart';

const sourceSansPro = 'SourceSansPro';
const roboto = 'Roboto';

class ThemeColors {
  const ThemeColors();

  static const Color loginGradientStart = const Color(0xFFFFFFFF);
  static const Color loginGradientEnd = const Color(0xFFd4d4d4);
  static const Color loginButtonColor = const Color(0xFF15ff99);
  static const Color zurichBlue = const Color(0xFF000066);
  static const Color zurichOrange = const Color(0xFFF69C00);
  static const Color appBarBlue = const Color(0xFF0557AA);
  static const Color backgroundBlue = const Color(0xFFD6DFEE);
  static const Color emergencyRed = const Color(0xFFEA635C);
  static const Color lightGrey = const Color(0xFFF3F3F3);
  static const Color mediumGrey = const Color(0xFFA0A0A0);
  static const Color backgroundColor = const Color(0xFFFAFDFD);
  static const Color darkBlue = const Color(0xFF475B77);
  static const Color blue = const Color(0xFF4272B7);
  static const Color orangeMain = const Color(0xFFFF9101);
  static const Color darkText = const Color(0xFF3E3E3E);
  static const Color greyText = const Color(0xFF919191);
  static const Color greyCard = const Color(0xFFE2E2E2);
  static const Color orangeIcon = const Color(0xFFFFB350);
  static const Color greenText = const Color(0xFF5EB743);
  static const Color redText = const Color(0xFFEB4848);
  static const Color redBackground = const Color(0xFFFF6C6C);
  static const Color greenActive = const Color(0xFF4BD921);
  static const Color cream = const Color(0xFFFAE6CA);
  static const Color blueGrey = const Color(0xFFF3F5FB);
  static const Color tealCard = const Color(0xFFFAFDFD);
  static const Color blueCard = const Color(0xFFE3E8F0);
  static const Color lightBlueGradient = const Color(0xFFC7DCF9);
  static const Color darkBlueGradient = const Color(0xFF3F85E9);
  static const Color greyDisabled = const Color(0xFFA8BCD6);
  static const Color fieldNameColor = const Color(0xFF919191);
  static const Color lightBlueSolid = const Color(0xFFF1F4F8);
  static var lightBlue5 = Color(0xFF154991).withOpacity(0.05);
  static var lightBlue10 = Color(0xFF154991).withOpacity(0.10);
  static var lightBlue20 = Color(0xFF154991).withOpacity(0.20);
  static var darkBlue15 = const Color(0xFF475B77).withOpacity(0.15);
  static var lineColor = Color(0xFF707070).withOpacity(0.3);
  static var orange20 = Color(0xFFFFB350).withOpacity(0.2);
  static var green20 = Color(0xFF9FEFA3).withOpacity(0.2);
  static var greyLine = const Color.fromRGBO(112, 112, 112, 0.3);
  static var greyLine10 = Color(0xFF707070).withOpacity(0.3);
  static var blueGreyDisabled50 = Color(0xFF134790).withOpacity(0.5);
  static var orange50 = Color(0xFFFFB350).withOpacity(0.5);
  static var greyCard40 = Color(0xFFA8BCD5).withOpacity(0.4);
  static const orange50Solid = const Color(0xFFF8CC92);
  static const primaryGradient = const LinearGradient(
    colors: const [loginGradientStart, loginGradientEnd],
    stops: const [0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

class ThemeText {
  const ThemeText();
  static const TextStyle greyTextStyle12 = TextStyle(
      fontSize: 12, color: ThemeColors.greyText, fontFamily: sourceSansPro);
  static const TextStyle greyTextStyle14 = TextStyle(
      fontSize: 14, color: ThemeColors.greyText, fontFamily: sourceSansPro);
  static const TextStyle subPageTitle = TextStyle(
      fontSize: 22, fontWeight: FontWeight.w500, fontFamily: 'Roboto');
  static const TextStyle pageTitle =
      TextStyle(fontSize: 22, fontWeight: FontWeight.w400);
}
