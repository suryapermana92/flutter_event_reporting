import 'package:meta/meta.dart';

@immutable
abstract class AddSegnalazioniState {
  int selectedIndex;
}

class InitialAddSegnalazioniState extends AddSegnalazioniState {
  int selectedIndex = -1;
}

class isLoadingSegnalazioni extends AddSegnalazioniState {}

class isSavingSegnalazioni extends AddSegnalazioniState {}

class ReportNewSegnalazioniSuccess extends AddSegnalazioniState {}

class ReportNewSegnalazioniFailure extends AddSegnalazioniState {
  final String responseMessage;
  ReportNewSegnalazioniFailure({this.responseMessage});
}

class UpdateSegnalazioniSuccess extends AddSegnalazioniState {}

class UpdateSegnalazioniFailure extends AddSegnalazioniState {
  final String responseMessage;
  UpdateSegnalazioniFailure({this.responseMessage});
}
