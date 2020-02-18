import 'package:meta/meta.dart';

class AddressInformation {
  AddressInformation({
    @required this.country,
    @required this.postalCode,
    @required this.city,
    @required this.street
  });

    // Named Constructor
  AddressInformation.initialize({
    this.country = '',
    this.postalCode = '',
    this.city = '',
    this.street = '',
  });

  final String street;
  final String postalCode;
  final String city;
  final String country;

  // Returns new copy of BasicInformation
  AddressInformation copyWith({
    String country,
    String postalCode,
    String city,
    String street
  }) {
    return AddressInformation(
      country: country ?? this.country,
      postalCode: postalCode ?? this.postalCode,
      city: city ?? this.city,
      street: street ?? this.street,
    );
  }

  @override
  String toString() {
    return 'AddressInformation {'
      + ' country: $country,'
      + ' postalCode: $postalCode'
      + ' city: $city,'
      + ' street: $street'
      + ' }';
  }
}