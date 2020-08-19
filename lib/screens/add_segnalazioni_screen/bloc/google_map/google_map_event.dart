import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

@immutable
abstract class GoogleMapEvent {}

class OnMapCreated extends GoogleMapEvent {
  OnMapCreated({this.controller});
  final GoogleMapController controller;
}
