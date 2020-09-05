import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import './bloc.dart';

class GoogleMapBloc extends Bloc<GoogleMapEvent, GoogleMapState> {
  GoogleMapBloc() : super(InitialGoogleMapState());

  @override
  GoogleMapState get initialState => InitialGoogleMapState();
  bool isView;
  LatLng _initialPosition = LatLng(43.769562, 11.255814);
  Completer<GoogleMapController> controller;
  GoogleMapController mapController;
  bool isMapCreated;
  @override
  Stream<GoogleMapState> mapEventToState(
    GoogleMapEvent event,
  ) async* {
    if (event is OnMapCreated) {
      if (controller == null) {
        controller = new Completer();
        controller.complete(event.controller);
      }
      mapController = event.controller;
      isMapCreated = true;
    }
    yield (MapLoaded());
    // TODO: Add Logic
  }
}

GoogleMapBloc googleMapBloc = new GoogleMapBloc();
