import 'package:equatable/equatable.dart';
import 'package:fluttersismic/screens/dashboard_screen/models/dashboard_data_response.dart';

abstract class DashboardScreenEvent extends Equatable {
  const DashboardScreenEvent();
  @override
  List<Object> get props => [];
}

class GetDashboardResponse extends DashboardScreenEvent {}
