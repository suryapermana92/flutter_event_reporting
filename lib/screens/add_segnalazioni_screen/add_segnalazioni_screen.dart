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
  Completer<GoogleMapController> _controller = googleMapBloc.controller;
  GoogleMapController mapController = googleMapBloc.mapController;
  bool isMapCreated = googleMapBloc.isMapCreated;
  Segnalazioni editingSegnalazioni;
  @override
  void initState() {
    addSegnalazioniBloc = BlocProvider.of<AddSegnalazioniBloc>(context);

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
      _nomeController.text = editingSegnalazioni.richiedenteNominativoNome;
      _cognomeController.text =
          editingSegnalazioni.richiedenteNominativoCognome;
      _emailController.text = editingSegnalazioni.richiedenteEmail;
      _telefonoController.text = editingSegnalazioni.richiedenteTelefono;
      _indrizzoController.text = editingSegnalazioni.eventoIndirizzo1;
      _civicoController.text = editingSegnalazioni.eventoCivico1;
      _comuneController.text = editingSegnalazioni.eventoComune;
      _ubicazioneController.text = editingSegnalazioni.eventoUbicazione;
      //load card data here
    }
    super.initState();
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
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Container(
                              height: 200,
                              width: MediaQuery.of(context).size.width,
                              child: Center(
                                child: GoogleMap(
//                  trafficEnabled: true,
                                  myLocationEnabled: false,
                                  myLocationButtonEnabled: false,
                                  mapType: MapType.normal,
//                                  markers: Set<Marker>.of(markers.values),
                                  initialCameraPosition: CameraPosition(
                                      target: LatLng(43.769562, 11.255814),
                                      zoom: 15.0),
                                  onMapCreated:
                                      (GoogleMapController controller) {
                                    if (googleMapBloc.controller == null) {
                                      googleMapBloc.add(
                                          OnMapCreated(controller: controller));
                                    }
                                  },
                                ),
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
                                          'Longitude',
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
                                      ),
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
