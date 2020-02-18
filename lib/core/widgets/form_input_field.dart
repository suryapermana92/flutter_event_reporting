


import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class FormInputField extends StatelessWidget {

  FormInputField({
    //@required this.controller,
    @required this.placeholder,
    @required this.validator,
    @required this.onSaved,
    this.initialValue,
    this.isPassword,
    this.inputType,
  });

  // final TextEditingController controller;
  final Function validator;
  final String initialValue;
  final String placeholder;
  final bool isPassword;
  final TextInputType inputType; 
  final Function onSaved;

  @override
  Widget build(BuildContext context) {
    return (
      Padding(
        padding: const EdgeInsets.all(8),
        child: TextFormField(
          keyboardType: inputType,
          onSaved: this.onSaved,
          decoration: InputDecoration(
            hintText: this.placeholder,
            labelText: this.placeholder
          ),
          obscureText: isPassword == true,
          validator: this.validator,
        ),
      )
    );
  }
}