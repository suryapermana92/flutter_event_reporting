// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/router_utils.dart';
import 'package:ui_hlb_ekyc_mobile/features/products_list/presentation/pages/index.dart';
import 'package:ui_hlb_ekyc_mobile/features/apply_product/presentation/pages/apply_product.dart';
import 'package:ui_hlb_ekyc_mobile/features/apply_product/presentation/pages/steps/personal_information_page.dart';
import 'package:ui_hlb_ekyc_mobile/features/apply_product/presentation/pages/apply_product_form.dart';

class Router {
  static const productsListPage = '/';
  static const applyProductPage = '/apply-product-page';
  static const personalInformationPage = '/personal-information-page';
  static const applyProductFormPage = '/apply-product-form-page';
  static GlobalKey<NavigatorState> get navigatorKey =>
      getNavigatorKey<Router>();
  static NavigatorState get navigator => navigatorKey.currentState;

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Router.productsListPage:
        return MaterialPageRoute(
          builder: (_) => ProductsListPage(),
          settings: settings,
        );
      case Router.applyProductPage:
        if (hasInvalidArgs<String>(args, isRequired: true)) {
          return misTypedArgsRoute<String>(args);
        }
        final typedArgs = args as String;
        return MaterialPageRoute(
          builder: (_) => ApplyProductPage(productType: typedArgs),
          settings: settings,
        );
      case Router.personalInformationPage:
        return MaterialPageRoute(
          builder: (_) => PersonalInformationPage(),
          settings: settings,
        );
      case Router.applyProductFormPage:
        return MaterialPageRoute(
          builder: (_) => ApplyProductFormPage(),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}
