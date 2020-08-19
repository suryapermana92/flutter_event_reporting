import 'package:fluttersismic/models/segnalazioni_response.dart';
import 'package:fluttersismic/screens/add_segnalazioni_screen/bloc/add_segnalazioni_bloc.dart';
import 'package:fluttersismic/screens/segnalazioni_screen/bloc/bloc.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AddSegnalazioniEvent {}

class ResetEmploymentFormState extends AddSegnalazioniEvent {}

class GetSingleSegnalazioniData extends AddSegnalazioniEvent {
  GetSingleSegnalazioniData({this.id});
  final String id;
}

class UpdateSegnalazioniRequest extends AddSegnalazioniEvent {
  UpdateSegnalazioniRequest({this.id, this.segnalazioniForm});

  final Segnalazioni segnalazioniForm;
  final int id;
}

class ReportNewSegnalazioni extends AddSegnalazioniEvent {
  ReportNewSegnalazioni(this.segnalazioniForm);

  final Segnalazioni segnalazioniForm;
}
