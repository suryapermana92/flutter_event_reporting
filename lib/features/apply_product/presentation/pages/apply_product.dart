
import 'package:flutter/material.dart';
import 'package:ui_hlb_ekyc_mobile/router.gr.dart';
import 'package:meta/meta.dart';
 
class ApplyProductPage extends StatelessWidget {

  ApplyProductPage({
    @required this.productType,
  });

  final String productType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Apply Product')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TitleMessage(productType: productType),
            SizedBox(height: 16.0),
            SizedBox(height: 16.0),
            RaisedButton(
              child: Text('Go to Stepper Form'),
              onPressed: () {
                Router.navigator.popAndPushNamed(Router.applyProductFormPage);
              },
            ),
            SizedBox(height: 16.0),
            RaisedButton(
                child: Text('Go to Form'),
              onPressed: () {
                Router.navigator.popAndPushNamed(Router.personalInformationPage);
              },
            ),
          ]
        ),
      )
    );
  }
}

class TitleMessage extends StatelessWidget {
  TitleMessage({
    @required this.productType
  });
  final String productType;
  @override
  Widget build(BuildContext context) {
    
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          'Apply for a $productType',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        )
      ),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }
}