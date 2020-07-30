import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class AddSegnalazioniBloc
    extends Bloc<AddSegnalazioniEvent, AddSegnalazioniState> {
  AddSegnalazioniBloc() : super(initialState);
  @override
  static AddSegnalazioniState get initialState => InitialAddSegnalazioniState();

  List<EmploymentData> employments = [
    EmploymentData(
        employerName: 'ABC Department Store',
        workAddress: '123 Wolverhampton Street, East Anglia, Lagos',
        workEmail: 't.bag@abcdept.com',
        employerWebsite: 'www.abcdept.com',
        workPhoneNumber: '01944759',
        startDate: '16/07/2018',
        endDate: '',
        isCurrent: true),
    EmploymentData(
        employerName: 'New Haven Furnitures',
        workAddress: '88 Market Street, Ikeja, Lagos.',
        startDate: '02/02/2017',
        endDate: '10/05/2018',
        isCurrent: false),
    EmploymentData(
        employerName: 'Julius Berger Ltd.',
        workAddress: '345 South East Rd., Abuja, FCT.',
        startDate: '28/11/2015',
        endDate: '01/02/2017',
        isCurrent: false),
  ];

  @override
  Stream<AddSegnalazioniState> mapEventToState(
    AddSegnalazioniEvent event,
  ) async* {
    // TODO: Add Logic
    if (event is ResetEmploymentFormState) {
      yield InitialAddSegnalazioniState();
    }
  }
}

class EmploymentData {
  final String employerName;
  final String employerWebsite;
  final String workEmail;
  final String workPhoneNumber;
  final String workAddress;
  final String startDate;
  final String endDate;
  final bool isCurrent;

  EmploymentData({
    this.employerName,
    this.employerWebsite,
    this.workEmail,
    this.workPhoneNumber,
    this.workAddress,
    this.startDate,
    this.endDate,
    this.isCurrent,
  });
}
