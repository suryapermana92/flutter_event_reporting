import 'package:auto_route/auto_route_annotations.dart';
import 'package:ui_hlb_ekyc_mobile/features/apply_product/presentation/pages/apply_product.dart';
import 'package:ui_hlb_ekyc_mobile/features/apply_product/presentation/pages/apply_product_form.dart';
import 'package:ui_hlb_ekyc_mobile/features/apply_product/presentation/pages/steps/personal_information_page.dart';
import 'package:ui_hlb_ekyc_mobile/features/products_list/presentation/pages/index.dart';

@autoRouter
class $Router {
  @initial
  ProductsListPage productsListPage;
  ApplyProductPage applyProductPage;
  PersonalInformationPage personalInformationPage;
  ApplyProductFormPage applyProductFormPage;
}