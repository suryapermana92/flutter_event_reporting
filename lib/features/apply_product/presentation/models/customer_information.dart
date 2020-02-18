
import 'package:meta/meta.dart';

@immutable
class PersonalInformation {

  PersonalInformation({
    @required this.fullName,
    @required this.myKadNumber,
    @required this.mobileNumber,
    @required this.email,
  });

  // Named Constructor
  PersonalInformation.initialize({
    this.fullName = '',
    this.myKadNumber = '',
    this.mobileNumber = '',
    this.email = ''
  });

  final String fullName;
  final String myKadNumber;
  final String mobileNumber;
  final String email;

  // Returns new copy of BasicInformation
  PersonalInformation copyWith({
    String fullName,
    String myKadNumber,
    String mobileNumber,
    String email
  }) {
    return PersonalInformation(
      fullName: fullName ?? this.fullName,
      myKadNumber: myKadNumber ?? this.myKadNumber,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      email: email ?? this.email,
    );
  }

  @override
  String toString() {
    return 'BasicInformation{'
      + ' fullName: $fullName,'
      + ' myKadNumber: $myKadNumber'
      + ' mobileNumber: $mobileNumber,'
      + ' email: $email'
      + ' }';
  }

  Map<String, dynamic> toJson() {
    return {
      fullName: fullName,
      myKadNumber: myKadNumber,
      mobileNumber: mobileNumber,
      email: email
    };
  }
}