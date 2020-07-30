import 'package:fluttersismic/screens/add_segnalazioni_screen/bloc/add_segnalazioni_bloc.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AddSegnalazioniEvent {}

class ResetEmploymentFormState extends AddSegnalazioniEvent {}

class GetEmploymentList extends AddSegnalazioniEvent {}

class UpdateEmploymentForm extends AddSegnalazioniEvent {
  UpdateEmploymentForm({this.employmentData});

  final EmploymentData employmentData;
}

class AddEmploymentSuccess extends AddSegnalazioniEvent {}
