import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:fluttersismic/screens/dashboard_screen/models/dashboard_data_response.dart';
import 'package:fluttersismic/screens/dashboard_screen/repositories/dashboard_service.dart';
import './bloc.dart';

class DashboardScreenBloc
    extends Bloc<DashboardScreenEvent, DashboardScreenState> {
  final DashboardService _dasboardService;

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
    }
  }

  Stream<DashboardScreenState> _mapGetDashboardResponseToState(
      GetDashboardResponse event) async* {
    yield DashboardLoading();
    try {
      final response = await _dasboardService.getDashboardData();
      if (response != null) {
        if (response.statusCode == 200) {
          yield GetDashboardResponseSuccess(
              response: dashboardResponseFromJson(response.body));
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
}
