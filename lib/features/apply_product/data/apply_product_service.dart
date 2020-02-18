
import 'package:meta/meta.dart';

import '../../../core/services/http_service.dart';
import '../presentation/models/models.dart';


// Will start use flutter retrofit or chopper library dependece 
class ApplyProductService extends HttpService {

  static final String submitFormApi = 'customers/form/submit';

  // Change Return type from String to Model class type
  Future<String> saveForm({
    @required PersonalInformation personalInformation,
  }) async {
    try {
      final Map<String, dynamic> data = personalInformation.toJson();
      final response = await this.post(url: submitFormApi, data: data);
      // todo:- Convert response to model class and return
      return response;
    } catch (err) {
      // Validate exception
      throw err;
    }
  }
}