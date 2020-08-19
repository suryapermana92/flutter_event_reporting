import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:fluttersismic/screens/segnalazioni_screen/repositories/segnalazioni_service.dart';
import './bloc.dart';

class AddSegnalazioniBloc
    extends Bloc<AddSegnalazioniEvent, AddSegnalazioniState> {
  final SegnalazioniService _segnalazioniService;

  AddSegnalazioniBloc(SegnalazioniService segnalazioniService)
      : assert(segnalazioniService != null),
        _segnalazioniService = segnalazioniService,
        super(InitialAddSegnalazioniState());
  @override
  static AddSegnalazioniState get initialState => InitialAddSegnalazioniState();

  @override
  Stream<AddSegnalazioniState> mapEventToState(
    AddSegnalazioniEvent event,
  ) async* {
    // TODO: Add Logic
    if (event is ResetEmploymentFormState) {
      yield InitialAddSegnalazioniState();
    } else if (event is GetSingleSegnalazioniData) {
      print('Get Single Data');
      yield InitialAddSegnalazioniState();
    } else if (event is UpdateSegnalazioniRequest) {
      print('Update Segnalazioni');
      yield isSavingSegnalazioni();
      try {
        final response = await _segnalazioniService.updateSegnalazioni(
            id: event.id, segnalazioniData: event.segnalazioniForm);
        if (response != null) {
          if (response.statusCode == 200) {
            yield UpdateSegnalazioniSuccess();
            print("UpdateSegnalazioniSuccess");
//          yield LoginInitial();
          } else {
            yield UpdateSegnalazioniFailure(
                responseMessage:
                    'Failed to Report Segnalazioni, please try again later');
          }
          // push new authentication event

        } else {
          yield ReportNewSegnalazioniFailure(
              responseMessage: 'Something very weird just happened');
        }
      } catch (err) {
        yield ReportNewSegnalazioniFailure(
            responseMessage: err.toString() ?? 'An unknown error occured');
      }
      yield InitialAddSegnalazioniState();
    } else if (event is ReportNewSegnalazioni) {
      print('Report New Segnalazioni');
      yield isSavingSegnalazioni();
      try {
        final response =
            await _segnalazioniService.postSegnalazioni(event.segnalazioniForm);
        if (response != null) {
          if (response.statusCode == 200) {
            yield ReportNewSegnalazioniSuccess();
            print("ReportNewSegnalazioniSuccess");
//          yield LoginInitial();
          } else {
            yield ReportNewSegnalazioniFailure(
                responseMessage:
                    'Failed to Report Segnalazioni, please try again later');
          }
          // push new authentication event

        } else {
          yield ReportNewSegnalazioniFailure(
              responseMessage: 'Something very weird just happened');
        }
      } catch (err) {
        yield ReportNewSegnalazioniFailure(
            responseMessage: err.toString() ?? 'An unknown error occured');
      }
      yield InitialAddSegnalazioniState();
    }
  }
}
