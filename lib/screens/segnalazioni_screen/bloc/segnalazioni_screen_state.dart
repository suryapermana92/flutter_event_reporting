import 'package:meta/meta.dart';

@immutable
abstract class SegnalazioniScreenState {}

class InitialSegnalazioniScreenState extends SegnalazioniScreenState {}

class IsLoadingSegnalazioniList extends SegnalazioniScreenState {}

class GetSegnalazioniListSuccess extends SegnalazioniScreenState {}

class GetSegnalazioniListFailure extends SegnalazioniScreenState {
  final String responseMessage;
  GetSegnalazioniListFailure({this.responseMessage});
}

class DeleteSegnalazioniSuccess extends SegnalazioniScreenState {}

class DeleteSegnalazioniFailure extends SegnalazioniScreenState {}
