

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_hlb_ekyc_mobile/core/widgets/form_input_field.dart';
import 'package:ui_hlb_ekyc_mobile/router.gr.dart';
import '../../models/models.dart';
import '../../bloc/new_form_bloc/bloc.dart';

class PersonalInformationForm extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _PersonalInformationFormState();
}

class _PersonalInformationFormState extends State<PersonalInformationForm> {
  GlobalKey<FormState> _formKey = GlobalKey();
  NewFormBloc _bloc;

  String _fullName;
  String _myKadNumber;
  String _email;
  String _mobileNumber;

  @override
  void initState() {
    super.initState();
  }


  @override
  void dispose() {
    // Do not forget to close bloc. May cause memory leak 
    _bloc?.close();
    super.dispose();
  }

  void _showSnackBar({String message}) {
    // Show snack bar message
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(message)
    ));
  }

  void onFormSave() async {
    if(_formKey.currentState.validate()) {
      _formKey.currentState.save();
      await _bloc.add(SavePersonalInformation(personalInformation: PersonalInformation(
        fullName: _fullName,
        myKadNumber: _myKadNumber,
        email: _email,
        mobileNumber: _mobileNumber
      )));
    }
   
  }
  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<NewFormBloc>(context);
    return BlocListener<NewFormBloc, NewFormState>(
      listener: (context, state) {
          if(state is NewFormSaving) {
            _showSnackBar(message: state.message);
          }
          if(state is NewFormSubmitted) {
            _showSnackBar(message: state.message);
          }
          if(state is NewFormSubmitFailed) {
            _showSnackBar(message: state.message);
          }
      },
      child: BlocBuilder<NewFormBloc, NewFormState>(
        bloc: _bloc,
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: ListView(
              physics: ClampingScrollPhysics(),
              children: <Widget>[
                FormInputField(
                  placeholder: "Full name as in MyKad",
                  validator: null,
                  onSaved: (value) => _fullName,
                ),
                FormInputField(
                  placeholder: "MyKad number",
                  validator: _bloc.isValidMyKadNumber,
                  onSaved: (value) => _myKadNumber
                ),
                FormInputField(
                  placeholder: "Email",
                  inputType: TextInputType.emailAddress,
                  validator: _bloc.isValidEmail,
                  onSaved: (value) => _email
                ),
                FormInputField(
                  placeholder: "Mobile number",
                  inputType: TextInputType.phone,
                  validator: _bloc.isValidMobileNum,
                  onSaved: (value) => _mobileNumber
                ),
                SizedBox(
                  height: 10.0,
                ),
                ButtonBar(
                  children: <Widget>[
                    RaisedButton(
                      child: Text('Cancel'),
                      onPressed: Router.navigator.pop,
                    ),
                    RaisedButton(
                      child: Text((state is NewFormSaving) ? 'Saving...!' : 'Save'),
                      onPressed: (state is NewFormSaving) ? null : onFormSave,
                    ),
                  ]
                )
              ],
            ),
          );
        }
      )
    );
  }
}