import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttersismic/screens/segnalazioni_screen/registeredEmploymentList.dart';
import 'package:fluttersismic/styles/theme.dart';
import 'package:fluttersismic/widgets/index.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'bloc/bloc.dart';

class SegnalazioniScreen extends StatefulWidget {
  @override
  _SegnalazioniScreenState createState() => _SegnalazioniScreenState();
}

class _SegnalazioniScreenState extends State<SegnalazioniScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String pageTitle = 'Segnalazioni';
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _phoneNumberController = new TextEditingController();
  var _phoneNumberFormatter =
      new MaskTextInputFormatter(mask: '+### (#)##########');
  var _dobController = new MaskTextInputFormatter(mask: '## / ## / ##');
  SegnalazioniScreenBloc segnalazioniScreenBloc;
  @override
  void initState() {
    // TODO: implement initState
    segnalazioniScreenBloc = BlocProvider.of<SegnalazioniScreenBloc>(context);
    segnalazioniScreenBloc.add(GetSegnalazioniList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBarComponent(
          title: pageTitle,
          context: context,
          scaffoldKey: () => _scaffoldKey.currentState.openDrawer(),
        ),
        body: Container(
          color: ThemeColors.backgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 20),
                    Text(
                      'Search',
                      style: TextStyle(fontFamily: sourceSansPro, fontSize: 18),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      'Your personal info is never shown to any other users.',
                      style: ThemeText.greyTextStyle12,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  child: RegisteredEmploymentList(),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                  ),
                  elevation: 0,
                  padding: EdgeInsets.all(0),
                  onPressed: () {
//                    SegnalazioniScreenBloc.add(EditEmployment(-1));
//                    Navigator.of(context).pushNamed(addSegnalazioniScreen);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    height: 45,
                    decoration: BoxDecoration(
                        color: ThemeColors.backgroundColor,
                        border: Border.all(color: ThemeColors.orangeMain),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.add,
                            color: ThemeColors.orangeMain,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Aggiungi",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: ThemeColors.orangeMain,
                                fontWeight: FontWeight.w600,
                                fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ));
  }
}
