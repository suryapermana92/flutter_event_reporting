import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttersismic/models/segnalazioni_response.dart';
import 'package:fluttersismic/screens/dashboard_screen/bloc/bloc.dart';
import 'package:fluttersismic/screens/segnalazioni_screen/bloc/bloc.dart';
import 'package:fluttersismic/styles/theme.dart';
import 'package:fluttersismic/utils/route_generator.dart';
import 'package:fluttersismic/widgets/index.dart';

import '../add_segnalazioni_screen/bloc/bloc.dart';

class RegisteredEmploymentList extends StatefulWidget {
  @override
  _RegisteredEmploymentListState createState() =>
      _RegisteredEmploymentListState();
}

class _RegisteredEmploymentListState extends State<RegisteredEmploymentList> {
  @override
  void initState() {
    // TODO: implement initState
    segnalazioniScreenBloc.add(GetSegnalazioniList());
    super.initState();
  }

  renderSegnalazioniList(data) {
    List<Segnalazioni> segnalazioniList = data;

    return segnalazioniList
        .asMap()
        .map((index, record) {
          String tipologieSegnalazioni = dashboardScreenBloc
              .segnalazionTipologiaData
              .firstWhere(
                  (element) => element.id == record.idTipologieSegnalazioni)
              .descrizione;
          return MapEntry(
              index,
              Column(
                children: <Widget>[
                  Slidable(
                    actionPane: SlidableScrollActionPane(),
                    actionExtentRatio: 0.2,
                    secondaryActions: <Widget>[
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
//                            employmentInformationScreenBloc
//                                .add(EditEmployment(index));
                            segnalazioniScreenBloc
                                .add(EditSegnalazioni(id: record.id));
                            Navigator.of(context)
                                .pushNamed(addSegnalazioniScreen);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  height: 34,
                                  width: 34,
                                  decoration: BoxDecoration(
                                      color: ThemeColors.orangeIcon,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8))),
                                  child: Center(
                                      child: Image.asset(
                                    'assets/drawable-xxxhdpi/edit.png',
                                    width: 12.3,
                                  )),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Edit',
                                  style: TextStyle(
                                      fontFamily: sourceSansPro, fontSize: 10),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            segnalazioniScreenBloc
                                .add(ViewSegnalazioni(id: record.id));
                            Navigator.of(context)
                                .pushNamed(addSegnalazioniScreen);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  height: 34,
                                  width: 34,
                                  decoration: BoxDecoration(
                                      color: ThemeColors.appBarBlue,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8))),
                                  child: Center(
                                      child: Image.asset(
                                    'assets/drawable-xxxhdpi/edit.png',
                                    width: 12.3,
                                  )),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'View',
                                  style: TextStyle(
                                      fontFamily: sourceSansPro, fontSize: 10),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            segnalazioniScreenBloc
                                .add(DeleteSegnalazioniList(id: record.id));
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  height: 34,
                                  width: 34,
                                  decoration: BoxDecoration(
                                      color: ThemeColors.redBackground,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8))),
                                  child: Center(
                                      child: Image.asset(
                                    'assets/drawable-xxxhdpi/remove.png',
                                    width: 12.3,
                                  )),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Delete',
                                  style: TextStyle(
                                      fontFamily: sourceSansPro, fontSize: 10),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                      record.richiedenteNominativoNome != null
                                          ? record.richiedenteNominativoNome
                                          : "N/A",
                                      style: TextStyle(
                                          fontFamily: sourceSansPro,
                                          color: ThemeColors.darkBlue)),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
//                                    '${record.eventoComune != "" ? record.eventoComune + ", " : record.eventoComune} ${record.eventoIndirizzo1 != "" ? record.eventoIndirizzo1 + "," : record.eventoIndirizzo1} ${record.eventoCivico1 != "" ? record.eventoCivico1 + "," : record.eventoCivico1} ${record.eventoIndirizzo2 != "" ? record.eventoIndirizzo2 + "," : record.eventoIndirizzo2} ${record.eventoCivico2 != "" ? record.eventoCivico2 + "," : record.eventoCivico2} ${record.eventoUbicazione}',
                                    '${record.eventoComune != "" ? record.eventoComune + ", " : record.eventoComune} ${record.eventoIndirizzo1 != "" ? record.eventoIndirizzo1 + "," : record.eventoIndirizzo1} ${record.eventoCivico1 != "" ? record.eventoCivico1 + "," : record.eventoCivico1}  ${record.eventoUbicazione}',
                                    style: TextStyle(fontFamily: sourceSansPro),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                '${tipologieSegnalazioni}',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: sourceSansPro,
                                    color: ThemeColors.greyText),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  ListDivider(
                    height: 0.5,
                    margin: EdgeInsets.only(
                        bottom: 20, top: 15, left: 20, right: 20),
                  )
                ],
              ));
        })
        .values
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SegnalazioniScreenBloc, SegnalazioniScreenState>(
        bloc: segnalazioniScreenBloc,
        listener: (context, state) {
          if (state is DeleteSegnalazioniSuccess) {}
        },
        builder: (context, state) {
          if (state is! IsLoadingSegnalazioniList) {
            return SingleChildScrollView(
              child: Column(
                children: renderSegnalazioniList(
                    segnalazioniScreenBloc.segnalazioniList),
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}
