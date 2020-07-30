import 'package:meta/meta.dart';

@immutable
abstract class AddSegnalazioniState {
  int selectedIndex;
}

class InitialAddSegnalazioniState extends AddSegnalazioniState {
  int selectedIndex = -1;
}

class isLoadingSegnalazioni extends AddSegnalazioniState {}
