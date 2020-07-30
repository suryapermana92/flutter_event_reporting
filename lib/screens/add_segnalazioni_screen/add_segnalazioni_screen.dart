//import 'package:flutter/gestures.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:fluttersismic/screens/add_segnalazioni_screen/bloc/add_segnalazioni_bloc.dart';
//import 'package:fluttersismic/styles/theme.dart';
//import 'package:fluttersismic/widgets/index.dart';
//
//
//class AddSegnalazioniScreen extends StatefulWidget {
//  AddSegnalazioniScreen({Key key});
//  @override
//  _AddSegnalazioniScreenState createState() => _AddSegnalazioniScreenState();
//}
//
//class _AddSegnalazioniScreenState extends State<AddSegnalazioniScreen> {
//  TextEditingController _employerNameController = new TextEditingController();
//  TextEditingController _employerWebsiteController =
//      new TextEditingController();
//  TextEditingController _workEmailController = new TextEditingController();
//  TextEditingController _workPhoneController = new TextEditingController();
//  TextEditingController _workAddressController = new TextEditingController();
//  TextEditingController _startDateController = new TextEditingController();
//  TextEditingController _endDateController = new TextEditingController();
//  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
//  String pageTitle = 'Employee Information';
//  String pageSubTitle = 'Add employment details';
//  bool _isCurrent = false;
//  EmploymentData employment;
//
//  @override
//  void initState() {
//    AddSegnalazioniBloc employmentInformationScreenBloc =
//        BlocProvider.of<AddSegnalazioniBloc>(context);
//    // TODO: implement initState
//    int selectedIndex = employmentInformationScreenBloc.state.selectedIndex;
//    if (selectedIndex > -1) {
//      employment = employmentInformationScreenBloc.employments[selectedIndex];
//      _employerNameController.text = employment.employerName;
//      _employerWebsiteController.text = employment.employerWebsite;
//      _workAddressController.text = employment.workAddress;
//      _workEmailController.text = employment.workEmail;
//      _workPhoneController.text = employment.workPhoneNumber;
//      _startDateController.text = employment.startDate;
//      _endDateController.text = employment.endDate;
//      _isCurrent = employment.isCurrent;
//    } else {
//      employmentInformationScreenBloc.add(ResetEmploymentFormState());
//    }
//    if (selectedIndex > -1) {
//      pageTitle = "Employee information";
//      pageSubTitle = 'Review employment details';
//      //load card data here
//    }
//
//    super.initState();
//  }
//
//  _updateEmploymentData() {
//    print("_isCurrent $_isCurrent");
//    AddSegnalazioniBloc employmentInformationScreenBloc =
//        BlocProvider.of<AddSegnalazioniBloc>(context);
//    employmentInformationScreenBloc.add(UpdateEmploymentForm(
//        employmentData: EmploymentData(
//      employerName: _employerNameController.text,
//      employerWebsite: _employerWebsiteController.text,
//      workAddress: _workAddressController.text,
//      workEmail: _workEmailController.text,
//      workPhoneNumber: _workPhoneController.text,
//      startDate: _startDateController.text,
//      endDate: _endDateController.text,
//      isCurrent: _isCurrent,
//    )));
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    AddSegnalazioniBloc employmentInformationScreenBloc =
//        BlocProvider.of<AddSegnalazioniBloc>(context);
//    return Scaffold(
//        key: _scaffoldKey,
//        appBar: AppBarComponent(
//          title: pageTitle,
//          context: context,
//          scaffoldKey: () => _scaffoldKey.currentState.openDrawer(),
//        ),
//        body: BlocConsumer<AddSegnalazioniBloc,
//            AddSegnalazioniState>(
//          bloc: employmentInformationScreenBloc,
//          listener: (context, state) {
//            if (state is AddEmploymentSuccess) {
//              Navigator.of(context).pop();
//            }
//          },
//          builder: (context, state) {
//            return Container(
//              color: ThemeColors.backgroundColor,
//              child: Column(
//                crossAxisAlignment: CrossAxisAlignment.start,
//                children: <Widget>[
//                  Padding(
//                    padding: const EdgeInsets.all(20.0),
//                    child: Column(
//                      crossAxisAlignment: CrossAxisAlignment.start,
//                      children: <Widget>[
//                        Text(
//                          pageSubTitle,
//                          style: TextStyle(
//                              fontFamily: sourceSansPro, fontSize: 18),
//                        ),
//                        SizedBox(
//                          height: 3,
//                        ),
//                        Text(
//                          'Your personal info is never shown to any other users.',
//                          style: ThemeText.greyTextStyle12,
//                        ),
//                      ],
//                    ),
//                  ),
//                  Expanded(
//                    child: SingleChildScrollView(
//                      child: Container(
//                        padding: EdgeInsets.all(20),
//                        child: Column(
//                          crossAxisAlignment: CrossAxisAlignment.start,
//                          children: <Widget>[
//                            Padding(
//                              padding: const EdgeInsets.symmetric(vertical: 8),
//                              child: Text(
//                                'Employer Name',
//                                style: TextStyle(
//                                    fontSize: 12,
//                                    color: ThemeColors.fieldNameColor),
//                              ),
//                            ),
//                            TextField(
//                              controller: _employerNameController,
//                              onChanged: (String text) {
//                                _updateEmploymentData();
//                              },
//                              keyboardType: TextInputType.text,
//                              decoration: InputDecoration(
//                                  border: OutlineInputBorder(
//                                    borderRadius: BorderRadius.circular(10),
//                                    borderSide: BorderSide(
//                                      width: 0,
//                                      style: BorderStyle.none,
//                                    ),
//                                  ),
//                                  contentPadding: EdgeInsets.all(12),
//                                  fillColor: ThemeColors.lightBlue5,
//                                  filled: true,
//                                  counter: SizedBox.shrink()
//
////                                      hintText: "Email",
//                                  ),
//                            ),
//                            Padding(
//                              padding: const EdgeInsets.symmetric(vertical: 8),
//                              child: Text(
//                                'Employer website',
//                                style: TextStyle(
//                                    fontSize: 12,
//                                    color: ThemeColors.fieldNameColor),
//                              ),
//                            ),
//                            TextField(
//                              controller: _employerWebsiteController,
//                              onChanged: (String text) {
//                                _updateEmploymentData();
//                              },
//                              keyboardType: TextInputType.text,
//                              decoration: InputDecoration(
//                                border: OutlineInputBorder(
//                                  borderRadius: BorderRadius.circular(10),
//                                  borderSide: BorderSide(
//                                    width: 0,
//                                    style: BorderStyle.none,
//                                  ),
//                                ),
//                                contentPadding: EdgeInsets.all(12),
//                                fillColor: ThemeColors.lightBlue5,
//                                filled: true,
//
////                                      hintText: "Email",
//                              ),
//                            ),
//                            SizedBox(
//                              height: 20,
//                            ),
//                            Row(
//                              children: <Widget>[
//                                Expanded(
//                                  flex: 4,
//                                  child: Column(
//                                    crossAxisAlignment:
//                                        CrossAxisAlignment.start,
//                                    children: <Widget>[
//                                      Padding(
//                                        padding: const EdgeInsets.symmetric(
//                                            vertical: 8),
//                                        child: Text(
//                                          'Work Email',
//                                          style: TextStyle(
//                                              fontSize: 12,
//                                              color:
//                                                  ThemeColors.fieldNameColor),
//                                        ),
//                                      ),
//                                      TextField(
//                                        controller: _workEmailController,
//                                        onChanged: (String text) {
//                                          _updateEmploymentData();
//                                        },
//                                        keyboardType:
//                                            TextInputType.emailAddress,
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
//                                  flex: 3,
//                                  child: Column(
//                                    crossAxisAlignment:
//                                        CrossAxisAlignment.start,
//                                    children: <Widget>[
//                                      Padding(
//                                        padding: const EdgeInsets.symmetric(
//                                            vertical: 8),
//                                        child: Text(
//                                          'Work phone number',
//                                          style: TextStyle(
//                                              fontSize: 12,
//                                              color:
//                                                  ThemeColors.fieldNameColor),
//                                        ),
//                                      ),
//                                      TextField(
//                                        controller: _workPhoneController,
//                                        onChanged: (String text) {
//                                          _updateEmploymentData();
//                                        },
//                                        keyboardType: TextInputType.number,
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
//                                )
//                              ],
//                            ),
//                            Padding(
//                              padding: const EdgeInsets.symmetric(vertical: 8),
//                              child: Text(
//                                'Work Address',
//                                style: TextStyle(
//                                    fontSize: 12,
//                                    color: ThemeColors.fieldNameColor),
//                              ),
//                            ),
//                            TextField(
//                              controller: _workAddressController,
//                              onChanged: (String text) {
//                                _updateEmploymentData();
//                              },
//                              keyboardType: TextInputType.text,
//                              decoration: InputDecoration(
//                                border: OutlineInputBorder(
//                                  borderRadius: BorderRadius.circular(10),
//                                  borderSide: BorderSide(
//                                    width: 0,
//                                    style: BorderStyle.none,
//                                  ),
//                                ),
//                                contentPadding: EdgeInsets.all(12),
//                                fillColor: ThemeColors.lightBlue5,
//                                filled: true,
//
////                                      hintText: "Email",
//                              ),
//                            ),
//                            SizedBox(
//                              height: 20,
//                            ),
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
//                                        onChanged: (String text) {
//                                          _updateEmploymentData();
//                                        },
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
//                                        onChanged: (String text) {
//                                          _updateEmploymentData();
//                                        },
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
//                                        _updateEmploymentData();
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
//                            SizedBox(
//                              height: 30,
//                            ),
//                            ListDivider(
//                              height: 0.5,
//                              margin:
//                                  EdgeInsets.only(left: 20, right: 20, top: 20),
//                            ),
//                            SizedBox(
//                              height: 40,
//                            ),
//                            BlocBuilder<AddSegnalazioniBloc,
//                                AddSegnalazioniState>(
//                              bloc: employmentInformationScreenBloc,
//                              builder: (context, state) {
//                                return FullButton(
//                                  disabled: state.isSaving,
//                                  onPressed: state.isSaving
//                                      ? null
//                                      : () {
//                                          if (state.selectedIndex > -1) {
//                                            employmentInformationScreenBloc.add(
//                                                SaveEditEmployment(context));
//                                          } else {
//                                            employmentInformationScreenBloc.add(
//                                                SaveAddEmployment(context));
//                                          }
//                                        },
//                                  child: Center(
//                                    child: state.isSaving
//                                        ? GreyCircularProgressIndicator()
//                                        : Text(
//                                            'Save',
//                                            style:
//                                                TextStyle(color: Colors.white),
//                                          ),
//                                  ),
//                                );
//                              },
//                            ),
//                            SizedBox(
//                              height: 40,
//                            ),
//                          ],
//                        ),
//                      ),
//                    ),
//                  ),
//                ],
//              ),
//            );
//          },
//        ));
//  }
//}
