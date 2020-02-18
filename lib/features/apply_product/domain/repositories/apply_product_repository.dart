import 'package:meta/meta.dart';

import '../../presentation/models/models.dart';
import '../../data/apply_product_service.dart';

class ApplyProductRepository {
  final int delay = 5;

  // We will migrate this to DI (Dependency Injection)
  final ApplyProductService service = ApplyProductService();

  Future<String> submitForm({
    @required PersonalInformation personalInformation
  }) async {
    await Future.delayed(Duration(seconds: delay));
    await service.saveForm(personalInformation: personalInformation);
    return "Form saved successfully!";
  }

  /*
   * Save partial filled form to verify wether customer is ETB/ NTB
   */
  Future<String> verifyCustomerInfo({
    @required PersonalInformation personalInformation
  }) async {
    await Future.delayed(Duration(seconds: delay));
    return "<Response>";
  }

  Future<String> uploadDocuments({
    @required String documentName
    //@required <Document model name> document
  }) async {
    await Future.delayed(Duration(seconds: delay));
    return "Document uploaded successfully!";
  }

}