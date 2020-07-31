import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:fluttersismic/models/segnalazioni_list.dart';
import 'package:fluttersismic/screens/segnalazioni_screen/repositories/segnalazioni_service.dart';
import './bloc.dart';

class SegnalazioniScreenBloc
    extends Bloc<SegnalazioniScreenEvent, SegnalazioniScreenState> {
  final SegnalazioniService _segnalazioniService;

  SegnalazioniScreenBloc(SegnalazioniService segnalazioniService)
      : assert(segnalazioniService != null),
        _segnalazioniService = segnalazioniService,
        super(InitialSegnalazioniScreenState());

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
  List<SegnalazioniListData> segnalazioniList = [];
  @override
  static SegnalazioniScreenState get initialState =>
      InitialSegnalazioniScreenState();

  @override
  Stream<SegnalazioniScreenState> mapEventToState(
    SegnalazioniScreenEvent event,
  ) async* {
    // TODO: Add Logic
    if (event is GetSegnalazioniList) {
      yield IsLoadingSegnalazioniList();

      try {
        final response = await _segnalazioniService.getSegnalazioniList();
        if (response != null) {
          if (response.statusCode == 200) {
            SegnalazionList responseBody =
                segnalazionListFromJson(response.body);
            yield GetSegnalazioniListSuccess(response: responseBody);
//            segnalazioniList = responseBody.data;
            print("GetDashboardResponseSuccess");
//          yield LoginInitial();
          } else {
            yield GetSegnalazioniListFailure(
                responseMessage: response.reasonPhrase);
          }
          // push new authentication event

        } else {
          yield GetSegnalazioniListFailure(
              responseMessage: 'Something very weird just happened');
        }
      } catch (err) {
        yield GetSegnalazioniListFailure(
            responseMessage: err.toString() ?? 'An unknown error occured');
      }
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
