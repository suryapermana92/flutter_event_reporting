import 'package:meta/meta.dart';

@immutable
abstract class GoogleMapState {}

class InitialGoogleMapState extends GoogleMapState {}

class MapLoaded extends GoogleMapState {}
