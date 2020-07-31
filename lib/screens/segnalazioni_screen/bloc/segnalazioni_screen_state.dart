import 'package:fluttersismic/models/segnalazioni.dart';
import 'package:fluttersismic/models/segnalazioni_list.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SegnalazioniScreenState {}

class InitialSegnalazioniScreenState extends SegnalazioniScreenState {}

class IsLoadingSegnalazioniList extends SegnalazioniScreenState {}

class GetSegnalazioniListSuccess extends SegnalazioniScreenState {
  final SegnalazionList response;
  GetSegnalazioniListSuccess({this.response});
}

class GetSegnalazioniListFailure extends SegnalazioniScreenState {
  final String responseMessage;
  GetSegnalazioniListFailure({this.responseMessage});
}
