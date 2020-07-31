import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttersismic/models/segnalazioni_list.dart';
import 'package:fluttersismic/screens/segnalazioni_screen/bloc/bloc.dart';
import 'package:fluttersismic/styles/theme.dart';
import 'package:fluttersismic/widgets/index.dart';

import '../add_segnalazioni_screen/bloc/bloc.dart';

class RegisteredEmploymentList extends StatefulWidget {
  @override
  _RegisteredEmploymentListState createState() =>
      _RegisteredEmploymentListState();
}

class _RegisteredEmploymentListState extends State<RegisteredEmploymentList> {
  SegnalazioniScreenBloc segnalazioniScreenBloc;
  @override
  void initState() {
    // TODO: implement initState
    segnalazioniScreenBloc = BlocProvider.of<SegnalazioniScreenBloc>(context);
    segnalazioniScreenBloc.add(GetSegnalazioniList());
    super.initState();
  }

  renderSegnalazioniList(data) {
    List<SegnalazioniListData> segnalazioniList = data;

    return segnalazioniList
        .asMap()
        .map((index, record) {
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
//                            Navigator.of(context)
//                                .pushNamed(addEmploymentScreen);
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
//                            employmentInformationScreenBloc
//                                .add(RemoveEmployment(index));
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
//                            employmentInformationScreenBloc
//                                .add(RemoveEmployment(index));
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
                                  Text(record.richiedenteNominativoNome,
                                      style: TextStyle(
                                          fontFamily: sourceSansPro,
                                          color: ThemeColors.darkBlue)),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    record.richiedenteNominativoCognome,
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
                                '${record.eventoUbicazione}',
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
    return BlocBuilder<SegnalazioniScreenBloc, SegnalazioniScreenState>(
        bloc: segnalazioniScreenBloc,
        builder: (context, state) {
          if (state is GetSegnalazioniListSuccess) {
            return SingleChildScrollView(
              child: Column(
                children: renderSegnalazioniList(state.response.data),
              ),
            );
          }
          return CircularProgressIndicator();
        });
  }
}
