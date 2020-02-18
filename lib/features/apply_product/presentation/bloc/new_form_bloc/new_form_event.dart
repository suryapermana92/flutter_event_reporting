part of 'new_form_bloc.dart';

abstract class NewFormEvent extends Equatable {
  const NewFormEvent();
}

class SavePersonalInformation extends NewFormEvent {

  const SavePersonalInformation({
    @required this.personalInformation,
  });

  final PersonalInformation personalInformation;

  @override
  List<Object> get props => [personalInformation];
}

class SaveAddressInformation extends NewFormEvent {

  const SaveAddressInformation({
    @required this.addressInformation,
  });

  final AddressInformation addressInformation;

  @override
  List<Object> get props => [addressInformation];
}

class ResetBasicInformation extends NewFormEvent {
  @override
  List<Object> get props => [];
}