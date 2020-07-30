import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttersismic/styles/theme.dart';
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
    final AddSegnalazioniBloc employmentInformationScreenBloc =
        BlocProvider.of<AddSegnalazioniBloc>(context);
    employmentInformationScreenBloc.add(GetEmploymentList());
    super.initState();
  }

  renderSegnalazioniList() {
    final AddSegnalazioniBloc employmentInformationScreenBloc =
        BlocProvider.of<AddSegnalazioniBloc>(context);
//    EmploymentData user = employmentInformationScreenBloc.state.employmentData;
    List<EmploymentData> segnalazioniList =
        employmentInformationScreenBloc.employments;

    return segnalazioniList
        .asMap()
        .map((index, employment) {
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
                                  Text(employment.employerName,
                                      style: TextStyle(
                                          fontFamily: sourceSansPro,
                                          color: ThemeColors.darkBlue)),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    employment.workAddress,
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
                                '${employment.startDate} - ${employment.isCurrent ? 'date' : '${employment.endDate}'}',
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
    final AddSegnalazioniBloc employmentInformationScreenBloc =
        BlocProvider.of<AddSegnalazioniBloc>(context);
    return BlocBuilder<AddSegnalazioniBloc, AddSegnalazioniState>(
        bloc: employmentInformationScreenBloc,
        builder: (context, state) {
          if (state is isLoadingSegnalazioni) {
            return CircularProgressIndicator();
          }
          return SingleChildScrollView(
            child: Column(
              children: renderSegnalazioniList(),
            ),
          );
        });
  }
}
