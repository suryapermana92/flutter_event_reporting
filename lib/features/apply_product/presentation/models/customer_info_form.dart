
import 'package:meta/meta.dart';

import 'models.dart';

class CustomerInfoForm {

  CustomerInfoForm({
    @required this.personal,
    @required this.address,
  });

  factory CustomerInfoForm.initialize() => 
    CustomerInfoForm(
      personal: PersonalInformation.initialize(),
      address: AddressInformation.initialize(),
    );

  final PersonalInformation personal;
  final AddressInformation address;
}