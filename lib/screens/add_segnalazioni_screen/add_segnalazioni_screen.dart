import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttersismic/models/segnalazioni_response.dart';
import 'package:fluttersismic/screens/add_segnalazioni_screen/bloc/add_segnalazioni_bloc.dart';
import 'package:fluttersismic/screens/add_segnalazioni_screen/bloc/bloc.dart';
import 'package:fluttersismic/screens/add_segnalazioni_screen/bloc/google_map/bloc.dart';
import 'package:fluttersismic/screens/dashboard_screen/bloc/bloc.dart';
import 'package:fluttersismic/screens/dashboard_screen/models/segnalazioni_tipologia_response.dart';
import 'package:fluttersismic/screens/segnalazioni_screen/bloc/bloc.dart';
import 'package:fluttersismic/styles/theme.dart';
import 'package:fluttersismic/utils/route_generator.dart';
import 'package:fluttersismic/widgets/full_button.dart';
import 'package:fluttersismic/widgets/index.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:location/location.dart';

class AddSegnalazioniScreen extends StatefulWidget {
  AddSegnalazioniScreen({Key key});
  @override
  _AddSegnalazioniScreenState createState() => _AddSegnalazioniScreenState();
}

class _AddSegnalazioniScreenState extends State<AddSegnalazioniScreen> {
  TextEditingController _nomeController = new TextEditingController();
  TextEditingController _cognomeController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _telefonoController = new TextEditingController();
  TextEditingController _indrizzoController = new TextEditingController();
  TextEditingController _civicoController = new TextEditingController();
  TextEditingController _comuneController = new TextEditingController();
  TextEditingController _ubicazioneController = new TextEditingController();
  SegnalazionTipologiaData selectedTipologia;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String pageTitle = 'New Segnalazioni';
  String pageSubTitle = 'Please Fill in details';
  Segnalazioni segnalazioniForm;
  AddSegnalazioniBloc addSegnalazioniBloc;
  int selectedId;
  bool isView;
  Completer<GoogleMapController> _completer = googleMapBloc.controller;
  GoogleMapController mapController = googleMapBloc.mapController;
  bool isMapCreated = googleMapBloc.isMapCreated;
  Segnalazioni editingSegnalazioni;
  LatLng _initialPosition;
  LatLng currentPosition;
  final Set<Marker> _markers = {};

  var geocodeTimer;
  String addressString;

  @override
  void initState() {
    addSegnalazioniBloc = BlocProvider.of<AddSegnalazioniBloc>(context);
    _initialPosition = LatLng(43.769562, 11.255814);
    _markers.add(
      Marker(
        markerId: MarkerId("1"),
        position: _initialPosition,
        icon: BitmapDescriptor.defaultMarker,
      ),
    );
    // TODO: implement initState
    selectedId = segnalazioniScreenBloc.selectedId;
    isView = segnalazioniScreenBloc.isView;
    selectedTipologia = dashboardScreenBloc.segnalazionTipologiaData[0];
    if (selectedId > -1) {
      editingSegnalazioni = segnalazioniScreenBloc.segnalazioniList
          .firstWhere((element) => element.id == selectedId);
      selectedTipologia = dashboardScreenBloc.segnalazionTipologiaData
          .firstWhere((element) =>
              element.id == editingSegnalazioni.idTipologieSegnalazioni);
      pageTitle = "Edit Segnalazioni";
      pageSubTitle = 'Please Fill in details';
      populateTextField();
      //load card data here
    }

    super.initState();
  }

  void _getPlace(position) async {
    List<geocoding.Placemark> newPlace = await geocoding
        .GeocodingPlatform.instance
        .placemarkFromCoordinates(position.latitude, position.longitude,
            localeIdentifier: "en");

    // this is all you need
    geocoding.Placemark placeMark = newPlace[0];
    _civicoController.text = placeMark.name;
    _comuneController.text = placeMark.locality;
    _indrizzoController.text = placeMark.administrativeArea;
    _ubicazioneController.text = placeMark.postalCode;
  }

  void _getCoordinateThrottler() {
    if (geocodeTimer != null) {
      geocodeTimer.cancel();
    }
    if (_indrizzoController.text.length > 0 &&
        _civicoController.text.length > 0 &&
        _comuneController.text.length > 0 &&
        _ubicazioneController.text.length > 0) {
      geocodeTimer = Timer(Duration(seconds: 1), () => _getCoordinate());
    }
  }

  void _getCoordinate() async {
    final query =
        "${_indrizzoController.text}, ${_civicoController.text}, ${_comuneController.text}, ${_ubicazioneController.text}";
    List<geocoding.Location> coordinate =
        await geocoding.GeocodingPlatform.instance.locationFromAddress(query);

    // this is all you need
    geocoding.Location location = coordinate.first;
    final cameraPosition = CameraPosition(
        target: LatLng(location.latitude, location.longitude), zoom: 10);

    googleMapBloc.mapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    setState(() {
      currentPosition = LatLng(location.latitude, location.longitude);
      _markers.add(Marker(
          markerId: MarkerId("1"),
          position: LatLng(location.latitude, location.longitude)));
    });
    print('${location.latitude}, ${location.longitude}');
  }

  Future getMyPosition() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }
    final result = await location.getLocation();
    setState(() {
      currentPosition = LatLng(result.latitude, result.longitude);
      _markers.add(Marker(
          markerId: MarkerId("1"),
          position: LatLng(result.latitude, result.longitude)));
    });
    final cameraPosition = CameraPosition(
        target: LatLng(result.latitude, result.longitude), zoom: 10);
    _getPlace(LatLng(result.latitude, result.longitude));
    googleMapBloc.mapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  populateTextField() {
    _nomeController.text = editingSegnalazioni.richiedenteNominativoNome;
    _cognomeController.text = editingSegnalazioni.richiedenteNominativoCognome;
    _emailController.text = editingSegnalazioni.richiedenteEmail;
    _telefonoController.text = editingSegnalazioni.richiedenteTelefono;
    _indrizzoController.text = editingSegnalazioni.eventoIndirizzo1;
    _civicoController.text = editingSegnalazioni.eventoCivico1;
    _comuneController.text = editingSegnalazioni.eventoComune;
    _ubicazioneController.text = editingSegnalazioni.eventoUbicazione;
  }

  @override
  Widget build(BuildContext context) {
    AddSegnalazioniBloc employmentInformationScreenBloc =
        BlocProvider.of<AddSegnalazioniBloc>(context);
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBarComponent(
          title: pageTitle,
          context: context,
          scaffoldKey: () => _scaffoldKey.currentState.openDrawer(),
        ),
        body: BlocConsumer<AddSegnalazioniBloc, AddSegnalazioniState>(
          bloc: employmentInformationScreenBloc,
          listener: (context, state) {
            if (state is ReportNewSegnalazioniSuccess) {
              Navigator.of(context).pop();
              segnalazioniScreenBloc.add(GetSegnalazioniList());
            } else if (state is UpdateSegnalazioniSuccess) {
              Navigator.of(context).pop();
              segnalazioniScreenBloc.add(GetSegnalazioniList());

//              segnalazioniScreenBloc.add(UpdateSegnalazioni(id: selectedId));
            }
          },
          builder: (context, state) {
            return Container(
              color: ThemeColors.backgroundColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          pageSubTitle,
                          style: TextStyle(
                              fontFamily: sourceSansPro, fontSize: 18),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          'Your personal info is never shown to any other users.',
                          style: ThemeText.greyTextStyle12,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Tipologie Segnalazioni',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: ThemeColors.fieldNameColor),
                                ),
                                DropdownButton<SegnalazionTipologiaData>(
                                  isExpanded: true,
                                  value: selectedTipologia,
                                  iconSize: 42,
                                  icon: new Tab(
                                    icon: Container(
                                      height: 22,
                                      width: 22,
                                      child: Center(
                                        child: new Image.asset(
                                            "assets/drawable-xxxhdpi/arrow_down.png",
                                            width: 15,
                                            fit: BoxFit.contain),
                                      ),
                                    ),
                                  ),
                                  underline: SizedBox(),
                                  onChanged:
                                      (SegnalazionTipologiaData newData) {
                                    setState(() {
                                      selectedTipologia = newData;
                                    });
                                  },
                                  items: dashboardScreenBloc
                                      .segnalazionTipologiaData
                                      .map((SegnalazionTipologiaData data) {
                                    return new DropdownMenuItem<
                                        SegnalazionTipologiaData>(
                                      child: new Text(data.descrizione),
                                      value: data,
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: Text(
                                    'Nome',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: ThemeColors.fieldNameColor),
                                  ),
                                ),
                                TextField(
                                  controller: _nomeController,
                                  readOnly: isView,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.all(12),
                                    fillColor: ThemeColors.lightBlue5,
                                    filled: true,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: Text(
                                    'Cognome',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: ThemeColors.fieldNameColor),
                                  ),
                                ),
                                TextField(
                                  controller: _cognomeController,
                                  readOnly: isView,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.all(12),
                                    fillColor: ThemeColors.lightBlue5,
                                    filled: true,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: Text(
                                          'Email',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color:
                                                  ThemeColors.fieldNameColor),
                                        ),
                                      ),
                                      TextField(
                                        controller: _emailController,
                                        readOnly: isView,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              width: 0,
                                              style: BorderStyle.none,
                                            ),
                                          ),
                                          contentPadding: EdgeInsets.all(12),
                                          fillColor: ThemeColors.lightBlue5,
                                          filled: true,

//                                      hintText: "Email",
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: Text(
                                          'Telefono',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color:
                                                  ThemeColors.fieldNameColor),
                                        ),
                                      ),
                                      TextField(
                                        controller: _telefonoController,
                                        readOnly: isView,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              width: 0,
                                              style: BorderStyle.none,
                                            ),
                                          ),
                                          contentPadding: EdgeInsets.all(12),
                                          fillColor: ThemeColors.lightBlue5,
                                          filled: true,

//                                      hintText: "Email",
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: Text(
                                          'Indrizzo',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color:
                                                  ThemeColors.fieldNameColor),
                                        ),
                                      ),
                                      TextField(
                                        controller: _indrizzoController,
                                        readOnly: isView,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              width: 0,
                                              style: BorderStyle.none,
                                            ),
                                          ),
                                          contentPadding: EdgeInsets.all(12),
                                          fillColor: ThemeColors.lightBlue5,
                                          filled: true,

//                                      hintText: "Email",
                                        ),
                                        onChanged: (text) {
                                          _getCoordinateThrottler();
                                        },
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: Text(
                                          'Civico',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color:
                                                  ThemeColors.fieldNameColor),
                                        ),
                                      ),
                                      TextField(
                                        controller: _civicoController,
                                        readOnly: isView,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              width: 0,
                                              style: BorderStyle.none,
                                            ),
                                          ),
                                          contentPadding: EdgeInsets.all(12),
                                          fillColor: ThemeColors.lightBlue5,
                                          filled: true,

//                                      hintText: "Email",
                                        ),
                                        onChanged: (text) {
                                          _getCoordinateThrottler();
                                        },
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: Text(
                                          'Comune',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color:
                                                  ThemeColors.fieldNameColor),
                                        ),
                                      ),
                                      TextField(
                                        controller: _comuneController,
                                        readOnly: isView,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              width: 0,
                                              style: BorderStyle.none,
                                            ),
                                          ),
                                          contentPadding: EdgeInsets.all(12),
                                          fillColor: ThemeColors.lightBlue5,
                                          filled: true,

//                                      hintText: "Email",
                                        ),
                                        onChanged: (text) {
                                          _getCoordinateThrottler();
                                        },
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: Text(
                                          'Ubicazione',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color:
                                                  ThemeColors.fieldNameColor),
                                        ),
                                      ),
                                      TextField(
                                        controller: _ubicazioneController,
                                        readOnly: isView,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              width: 0,
                                              style: BorderStyle.none,
                                            ),
                                          ),
                                          contentPadding: EdgeInsets.all(12),
                                          fillColor: ThemeColors.lightBlue5,
                                          filled: true,

//                                      hintText: "Email",
                                        ),
                                        onChanged: (text) {
                                          _getCoordinateThrottler();
                                        },
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Text(addressString ?? ""),
                            Container(
                              height: 200,
                              width: MediaQuery.of(context).size.width,
                              child: Stack(
                                children: [
                                  Center(
                                    child: GoogleMap(
                                      markers: _markers,
//                  trafficEnabled: true,
                                      myLocationEnabled: false,
                                      myLocationButtonEnabled: true,
                                      mapType: MapType.normal,
                                      onTap: (LatLng position) {
                                        _getPlace(position);
                                        setState(() {
                                          currentPosition = position;
                                          _markers.add(Marker(
                                              markerId: MarkerId("1"),
                                              position: position));
                                        });
                                      },

                                      onCameraMove: (CameraPosition position) {
//                                    setState(() {
//                                      currentPosition = position.target;
//                                      _markers.add(Marker(
//                                          markerId: MarkerId("1"),
//                                          position: position.target));
//                                    });
                                      },
//                                  markers: Set<Marker>.of(markers.values),
                                      initialCameraPosition: CameraPosition(
                                          target: _initialPosition, zoom: 15.0),
                                      onMapCreated:
                                          (GoogleMapController controller) {
                                        googleMapBloc.add(OnMapCreated(
                                            controller: controller));
                                      },
                                    ),
                                  ),
                                  Positioned(
                                      top: 10,
                                      right: -5,
                                      child: RawMaterialButton(
                                        shape: CircleBorder(),
                                        onPressed: () {
                                          getMyPosition();
                                        },
                                        elevation: 2,
                                        fillColor: Colors.white,
                                        padding: EdgeInsets.all(15),
                                        child: Icon(Icons.my_location),
                                      )),
                                ],
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: Text(
                                          'Latitude',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color:
                                                  ThemeColors.fieldNameColor),
                                        ),
                                      ),
                                      Text(currentPosition != null
                                          ? ((currentPosition.latitude * 10000)
                                                      .round() /
                                                  10000)
                                              .toString()
                                          : ((_initialPosition.latitude * 10000)
                                                      .round() /
                                                  10000)
                                              .toString()
                                              .toString()),
                                      SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: Text(
                                          'Longitude',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color:
                                                  ThemeColors.fieldNameColor),
                                        ),
                                      ),
                                      Text(currentPosition != null
                                          ? ((currentPosition.longitude * 10000)
                                                      .round() /
                                                  10000)
                                              .toString()
                                          : ((_initialPosition.longitude *
                                                          10000)
                                                      .round() /
                                                  10000)
                                              .toString()
                                              .toString()),
                                      SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
//                            Row(
//                              children: <Widget>[
//                                Expanded(
//                                  child: Column(
//                                    crossAxisAlignment:
//                                        CrossAxisAlignment.start,
//                                    children: <Widget>[
//                                      Padding(
//                                        padding: const EdgeInsets.symmetric(
//                                            vertical: 8),
//                                        child: Text(
//                                          'Start date',
//                                          style: TextStyle(
//                                              fontSize: 12,
//                                              color:
//                                                  ThemeColors.fieldNameColor),
//                                        ),
//                                      ),
//                                      TextField(
//                                        controller: _startDateController,
//                                        keyboardType: TextInputType.text,
//                                        decoration: InputDecoration(
//                                          border: OutlineInputBorder(
//                                            borderRadius:
//                                                BorderRadius.circular(10),
//                                            borderSide: BorderSide(
//                                              width: 0,
//                                              style: BorderStyle.none,
//                                            ),
//                                          ),
//                                          contentPadding: EdgeInsets.all(12),
//                                          fillColor: ThemeColors.lightBlue5,
//                                          filled: true,
//
////                                      hintText: "Email",
//                                        ),
//                                      ),
//                                      SizedBox(
//                                        height: 20,
//                                      ),
//                                    ],
//                                  ),
//                                ),
//                                SizedBox(
//                                  width: 20,
//                                ),
//                                Expanded(
//                                  child: Column(
//                                    crossAxisAlignment:
//                                        CrossAxisAlignment.start,
//                                    children: <Widget>[
//                                      Padding(
//                                        padding: const EdgeInsets.symmetric(
//                                            vertical: 8),
//                                        child: Text(
//                                          'End date',
//                                          style: TextStyle(
//                                              fontSize: 12,
//                                              color:
//                                                  ThemeColors.fieldNameColor),
//                                        ),
//                                      ),
//                                      TextField(
//                                        controller: _endDateController,
//                                        keyboardType: TextInputType.text,
//                                        decoration: InputDecoration(
//                                          border: OutlineInputBorder(
//                                            borderRadius:
//                                                BorderRadius.circular(10),
//                                            borderSide: BorderSide(
//                                              width: 0,
//                                              style: BorderStyle.none,
//                                            ),
//                                          ),
//                                          contentPadding: EdgeInsets.all(12),
//                                          fillColor: ThemeColors.lightBlue5,
//                                          filled: true,
//
////                                      hintText: "Email",
//                                        ),
//                                      ),
//                                      SizedBox(
//                                        height: 20,
//                                      ),
//                                    ],
//                                  ),
//                                ),
//                                SizedBox(
//                                  width: 5,
//                                ),
//                                Column(
//                                  crossAxisAlignment: CrossAxisAlignment.start,
//                                  children: <Widget>[
//                                    Checkbox(
//                                      value: _isCurrent,
//                                      onChanged: (value) {
//                                        setState(() {
//                                          _isCurrent = !_isCurrent;
//                                        });
//                                      },
//                                    ),
//                                    Container(
//                                      padding: EdgeInsets.only(left: 15),
//                                      height: 44,
//                                      width: 70,
//                                      child: Text(
//                                        'Current work place',
//                                        style: ThemeText.greyTextStyle12,
//                                      ),
//                                    ),
//                                    SizedBox(
//                                      height: 20,
//                                    ),
//                                  ],
//                                ),
//                              ],
//                            ),
                            ListDivider(
                              height: 0.5,
                              margin:
                                  EdgeInsets.only(left: 20, right: 20, top: 20),
                            ),
                            BlocBuilder<AddSegnalazioniBloc,
                                AddSegnalazioniState>(
                              bloc: employmentInformationScreenBloc,
                              builder: (context, state) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: FullButton(
                                    disabled: (state is isSavingSegnalazioni ||
                                        state is isLoadingSegnalazioni),
                                    onPressed:
                                        (state is isSavingSegnalazioni ||
                                                state is isLoadingSegnalazioni)
                                            ? null
                                            : () {
//                                          _updateEmploymentData();
                                                Segnalazioni segnalazioniPayload = Segnalazioni(
                                                    id: segnalazioniScreenBloc
                                                        .selectedId,
                                                    richiedenteNominativoNome:
                                                        _nomeController.text,
                                                    richiedenteNominativoCognome:
                                                        _cognomeController.text,
                                                    richiedenteTelefono:
                                                        _telefonoController
                                                            .text,
                                                    richiedenteEmail:
                                                        _emailController.text,
                                                    eventoCivico1:
                                                        _civicoController.text,
                                                    eventoComune:
                                                        _comuneController.text,
                                                    eventoIndirizzo1:
                                                        _indrizzoController
                                                            .text,
                                                    eventoUbicazione:
                                                        _ubicazioneController
                                                            .text,
                                                    idTipologieSegnalazioni: 1,
                                                    eventoCoordinateLat: -120,
                                                    eventoCoordinateLon: 8);
                                                if (selectedId > -1) {
                                                  addSegnalazioniBloc.add(
                                                      UpdateSegnalazioniRequest(
                                                          id: segnalazioniScreenBloc
                                                              .selectedId,
                                                          segnalazioniForm:
                                                              segnalazioniPayload));
                                                } else {
                                                  addSegnalazioniBloc.add(
                                                      ReportNewSegnalazioni(
                                                          segnalazioniPayload));
                                                }
                                              },
                                    child: Center(
                                      child: (state is isSavingSegnalazioni)
                                          ? CircularProgressIndicator()
                                          : Text(
                                              selectedId > -1
                                                  ? "Update Report"
                                                  : 'Post New Report',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }
}
