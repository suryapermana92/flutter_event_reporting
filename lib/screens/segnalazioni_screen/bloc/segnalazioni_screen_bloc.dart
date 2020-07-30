import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class SegnalazioniScreenBloc
    extends Bloc<SegnalazioniScreenEvent, SegnalazioniScreenState> {
  SegnalazioniScreenBloc() : super(initialState);

  @override
  static SegnalazioniScreenState get initialState =>
      InitialSegnalazioniScreenState();

  @override
  Stream<SegnalazioniScreenState> mapEventToState(
    SegnalazioniScreenEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
