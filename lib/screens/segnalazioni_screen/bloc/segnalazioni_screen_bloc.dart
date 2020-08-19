import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:fluttersismic/models/segnalazioni_response.dart';
import 'package:fluttersismic/screens/segnalazioni_screen/repositories/segnalazioni_service.dart';
import './bloc.dart';

class SegnalazioniScreenBloc
    extends Bloc<SegnalazioniScreenEvent, SegnalazioniScreenState> {
  final SegnalazioniService _segnalazioniService;

  SegnalazioniScreenBloc(SegnalazioniService segnalazioniService)
      : assert(segnalazioniService != null),
        _segnalazioniService = segnalazioniService,
        super(InitialSegnalazioniScreenState());
  int selectedId = -1;
  bool isView = false;
  List<Segnalazioni> segnalazioniList = [];
  @override
  static SegnalazioniScreenState get initialState =>
      InitialSegnalazioniScreenState();

  @override
  Stream<SegnalazioniScreenState> mapEventToState(
    SegnalazioniScreenEvent event,
  ) async* {
    // TODO: Add Logic
    if (event is GetSegnalazioniList) {
      yield IsLoadingSegnalazioniList();

      try {
        final response = await _segnalazioniService.getSegnalazioniList();
        if (response != null) {
          if (response.statusCode == 200) {
            segnalazioniList = segnalazioniResponseFromJson(response.body).data;
            yield GetSegnalazioniListSuccess();
            print("GetSegnalazioniListSuccess");
          } else {
            yield GetSegnalazioniListFailure(
                responseMessage: response.reasonPhrase);
          }
        } else {
          yield GetSegnalazioniListFailure(
              responseMessage: 'Something very weird just happened');
        }
      } catch (err) {
        yield GetSegnalazioniListFailure(
            responseMessage: err.toString() ?? 'An unknown error occured');
      }
    } else if (event is DeleteSegnalazioniList) {
      yield IsLoadingSegnalazioniList();

      try {
        final response =
            await _segnalazioniService.deleteSegnalazioni(event.id);
        if (response != null) {
          if (response.statusCode == 200) {
            segnalazioniList.removeWhere((element) => element.id == event.id);
            yield DeleteSegnalazioniSuccess();
          } else {
            yield DeleteSegnalazioniFailure();
          }
          // push new authentication event

        } else {
          yield GetSegnalazioniListFailure(
              responseMessage: 'Something very weird just happened');
        }
      } catch (err) {
        yield GetSegnalazioniListFailure(
            responseMessage: err.toString() ?? 'An unknown error occured');
      }
    } else if (event is EditSegnalazioni) {
      selectedId = event.id;
      isView = false;
    } else if (event is ViewSegnalazioni) {
      selectedId = event.id;
      isView = true;
    }
  }
}

SegnalazioniScreenBloc segnalazioniScreenBloc =
    SegnalazioniScreenBloc(segnalazioniService);
