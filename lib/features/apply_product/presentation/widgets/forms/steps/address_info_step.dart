
import 'package:flutter/material.dart';
import 'package:ui_hlb_ekyc_mobile/core/utils/form_validators.dart';
import 'package:ui_hlb_ekyc_mobile/core/widgets/form_input_field.dart';

class AddressInfoStep extends StatelessWidget {

  static const String title = 'Address Information';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        FormInputField(
          placeholder: "Address (Line 1)",
          validator: (value) =>
            isBlank(value: value) ? 'Street Adress, Block, Unit' : null,
          onSaved: debugPrint,
        ),
        FormInputField(
          placeholder: "City",
          validator: (value) =>
              isBlank(value: value) ? 'Please enter City name' : null,
          onSaved: debugPrint,
        ),
        FormInputField(
          placeholder: "Postal Code",
          inputType: TextInputType.number,
          validator: (value) =>
            isBlank(value: value) ? 'Please enter postal code' : null,
          onSaved: debugPrint,
        ),
        FormInputField(
          placeholder: "Country",
          inputType: TextInputType.phone,
          validator: (value) => isBlank(value: value) ? 'Please enter Country name' : null,
          onSaved: debugPrint,
        ),
      ],
    );
  }
}