import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class AddSegnalazioniBloc
    extends Bloc<AddSegnalazioniEvent, AddSegnalazioniState> {
  AddSegnalazioniBloc() : super(initialState);
  @override
  static AddSegnalazioniState get initialState => InitialAddSegnalazioniState();

  @override
  Stream<AddSegnalazioniState> mapEventToState(
    AddSegnalazioniEvent event,
  ) async* {
    // TODO: Add Logic
    if (event is ResetEmploymentFormState) {
      yield InitialAddSegnalazioniState();
    }
  }
}
