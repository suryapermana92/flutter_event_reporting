

import 'package:flutter/material.dart';
import 'package:ui_hlb_ekyc_mobile/router.gr.dart';
import '../widgets/product_list_item.dart';

class ProductsListPage extends StatelessWidget {

  void navigateToApplyProduct({String productType}) {
    Router.navigator.pushNamed(Router.applyProductPage, arguments: productType);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Apply Products'),
      body: Center(
        child: Center(
          child: ListView(children: <Widget>[
            ProductListItem(
              title: 'Apply for a new CASA Account',
              onPressed: () {
                navigateToApplyProduct(productType: 'CASA Account');
              }
            ),
            ProductListItem(
              title: 'Apply for a new Personal Loan',
              onPressed: () {
                navigateToApplyProduct(productType: 'Personal Loan');
              }
            ),
          ])
        ),
      ),
    );
  }
}