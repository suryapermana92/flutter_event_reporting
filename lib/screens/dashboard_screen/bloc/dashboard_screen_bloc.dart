import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:fluttersismic/screens/dashboard_screen/models/dashboard_data_response.dart';
import 'package:fluttersismic/screens/dashboard_screen/models/segnalazioni_tipologia_response.dart';
import 'package:fluttersismic/screens/dashboard_screen/repositories/dashboard_service.dart';
import './bloc.dart';

class DashboardScreenBloc
    extends Bloc<DashboardScreenEvent, DashboardScreenState> {
  final DashboardService _dasboardService;
  DashboardResponse dashboardResponse;
  int selectedTipologia = -1;
  List<SegnalazionTipologiaData> segnalazionTipologiaData = [];

  DashboardScreenBloc(DashboardService dasboardService)
      : assert(dasboardService != null),
        _dasboardService = dasboardService,
        super(InitialDashboardScreenState());

  @override
  DashboardScreenState get initialState => InitialDashboardScreenState();

  @override
  Stream<DashboardScreenState> mapEventToState(
    DashboardScreenEvent event,
  ) async* {
    // TODO: Add Logic
    if (event is GetDashboardResponse) {
      yield* _mapGetDashboardResponseToState(event);
    } else if (event is GetSegnalazioniTipologiaResponse) {
      yield* _mapGetSegnalazioniTipologiaToState(event);
    }
  }

  Stream<DashboardScreenState> _mapGetDashboardResponseToState(
      GetDashboardResponse event) async* {
    yield DashboardLoading();
    try {
      final response = await _dasboardService.getDashboardData();
      if (response != null) {
        if (response.statusCode == 200) {
          dashboardResponse = dashboardResponseFromJson(response.body);
          yield GetDashboardResponseSuccess();
          print("GetDashboardResponseSuccess");
//          yield LoginInitial();
        } else {
          yield GetDashboardResponseFailure(
              responseMessage: 'Something very weird just happened');
        }
        // push new authentication event

      } else {
        yield GetDashboardResponseFailure(
            responseMessage: 'Something very weird just happened');
      }
    } catch (err) {
      yield GetDashboardResponseFailure(
          responseMessage: err.toString() ?? 'An unknown error occured');
    }
  }

  Stream<DashboardScreenState> _mapGetSegnalazioniTipologiaToState(
      GetSegnalazioniTipologiaResponse event) async* {
    yield DashboardLoading();
    try {
      final response = await _dasboardService.getSegnalazioniTipologia();
      if (response != null) {
        if (response.statusCode == 200) {
          segnalazionTipologiaData =
              segnalazionTipologiaResponseFromJson(response.body).data;

          yield GetSegnalazioniTipologiaSuccess();
          print("GetSegnalazioniTipologiaSuccess");
//          yield LoginInitial();
        } else {
          yield GetSegnalazioniTipologiaFailure(
              responseMessage: 'Something very weird just happened');
        }
        // push new authentication event

      } else {
        yield GetSegnalazioniTipologiaFailure(
            responseMessage: 'Something very weird just happened');
      }
    } catch (err) {
      yield GetSegnalazioniTipologiaFailure(
          responseMessage: err.toString() ?? 'An unknown error occured');
    }
  }
}

DashboardScreenBloc dashboardScreenBloc = DashboardScreenBloc(dashboardService);
