
import 'package:flutter/material.dart';
import 'package:ui_hlb_ekyc_mobile/core/utils/form_validators.dart';
import 'package:ui_hlb_ekyc_mobile/core/widgets/form_input_field.dart';

class PersonalInfoStep extends StatelessWidget {
  static const String title = 'Personal Information';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        FormInputField(
          placeholder: "Full name as in MyKad",
          validator: (value) =>
            isOnlyAlphabet(value: value) ? null : 'Please enter your Full name as in MyKad',
          onSaved: debugPrint,
        ),
        // FormInputField(
        //   placeholder: "First Name",
        //   validator: (value) =>
        //     isOnlyAlphabet(value: value) ? null : 'Please enter your First name',
        //   onSaved: debugPrint,
        // ),
        // FormInputField(
        //   placeholder: "Last Name",
        //   validator: null,
        //   onSaved: debugPrint,
        // ),
        FormInputField(
          placeholder: "MyKad number",
          validator: (value) =>
              isBlank(value: value) ? 'Please enter MyKad number' : null,
          onSaved: debugPrint
        ),
        FormInputField(
          placeholder: "Email",
          inputType: TextInputType.emailAddress,
          validator: (value) =>
            isEmail(value: value) ? null : 'Please enter a valid email',
          onSaved: debugPrint,
        ),
        FormInputField(
          placeholder: "Mobile number",
          inputType: TextInputType.phone,
          validator: (value) => isMobileNumber(value: value) ? null : 'Please enter a valid mobile number',
          onSaved: debugPrint,
        ),
      ],
    );
  }
}