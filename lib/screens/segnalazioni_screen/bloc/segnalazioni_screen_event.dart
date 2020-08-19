import 'package:meta/meta.dart';

@immutable
abstract class SegnalazioniScreenEvent {}

class GetSegnalazioniList extends SegnalazioniScreenEvent {}

class AddSegnalazioniList extends SegnalazioniScreenEvent {}

class DeleteSegnalazioniList extends SegnalazioniScreenEvent {
  DeleteSegnalazioniList({this.id});
  int id;
}

class EditSegnalazioni extends SegnalazioniScreenEvent {
  EditSegnalazioni({this.id});
  int id;
}

class ViewSegnalazioni extends SegnalazioniScreenEvent {
  ViewSegnalazioni({this.id});
  int id;
}

class UpdateSegnalazioni extends SegnalazioniScreenEvent {
  UpdateSegnalazioni({this.id});
  int id;
}
