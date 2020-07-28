import 'package:equatable/equatable.dart';
import 'package:fluttersismic/screens/dashboard_screen/models/dashboard_data_response.dart';
import 'package:fluttersismic/screens/dashboard_screen/models/dashboard_data_response.dart';
import 'package:fluttersismic/screens/dashboard_screen/models/dashboard_data_response.dart';
import 'package:fluttersismic/screens/dashboard_screen/models/dashboard_data_response.dart';

abstract class DashboardScreenState extends Equatable {
  const DashboardScreenState();
  @override
  List<Object> get props => [];
}

class InitialDashboardScreenState extends DashboardScreenState {}

class DashboardLoading extends DashboardScreenState {}

class GetDashboardResponseSuccess extends DashboardScreenState {
  final DashboardResponse response;
  GetDashboardResponseSuccess({this.response});
}

class GetDashboardResponseFailure extends DashboardScreenState {
  final String responseMessage;
  GetDashboardResponseFailure({this.responseMessage});
}
