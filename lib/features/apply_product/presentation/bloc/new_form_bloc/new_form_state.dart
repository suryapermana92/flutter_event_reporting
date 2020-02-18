part of 'new_form_bloc.dart';

class NewFormState extends Equatable { 

  NewFormState({
    @required this.form
  });

  factory NewFormState.initial() => NewFormState(form: CustomerInfoForm.initialize());

  final CustomerInfoForm form;

  @override
  List<Object> get props => [form];

  NewFormState copyWith({
    PersonalInformation personal,
    AddressInformation adress
  }) {
    return NewFormState(
      form: CustomerInfoForm(
        personal: personal ?? this.form?.personal,
        address: adress ?? this.form?.address,
      )
    );
  }

  @override
  String toString() {
    return "Form { "
           + " personal: ${form?.personal?.toString()}, "
           + " address: ${form?.address?.toString()} "
           + " }";
  }
}

class NewFormSaving extends NewFormState {
  NewFormSaving({
    @required this.message
  });

  final String message;
}

class NewFormSubmitted extends NewFormState {
  NewFormSubmitted({
    @required this.message
  });

  final String message;
}

class NewFormSubmitFailed extends NewFormState {
  NewFormSubmitFailed({
    @required this.message
  });

  final String message;
}
