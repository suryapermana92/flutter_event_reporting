import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:nodcredit/bloc/borrower_dashboard/bloc.dart';
//import 'package:nodcredit/common/index.dart';
import 'package:fluttersismic/styles/theme.dart' as Theme;
import 'package:fluttersismic/styles/theme.dart';
import 'package:fluttersismic/widgets/circular_slider/sleek_circular_slider.dart';
import 'package:fluttersismic/widgets/index.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Cubic _curves = Cubic(0.175, 0.885, 0.32, 1.075);
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = new ScrollController();
//  final DashboardBloc DashboardBloc =
//      new DashboardBloc();
  Duration _duration = Duration(milliseconds: 500);
  Duration _opacityDuration = Duration(milliseconds: 300);
  bool isExpanded = false;
  List<Color> _colors = [
    ThemeColors.darkBlueGradient,
    ThemeColors.lightBlueGradient
  ];
  List<double> _stops = [0.0, 0.7];
  int selectedInfoIndex = -1;

  @override
  void initState() {
    super.initState();
  }

  Widget renderSizedBox() {
    return Stack(
      children: <Widget>[
        isExpanded
            ? SizedBox(
                height: 875,
              )
            : SizedBox(
                height: 875,
              ),
        AnimatedPositioned(
          duration: _duration,
          curve: Curves.easeInOut,
          top: isExpanded ? 305 : 100,
          child: AnimatedOpacity(
              duration: _opacityDuration,
              opacity: isExpanded ? 1 : 0,
              child: Container(
                width: 100,
                height: 100,
              )
//            CompleteVerificationSection(),
              ),
        ),
      ],
    );
  }

  Widget AmountDueSection() {
    return Container(
      height: 115,
      width: MediaQuery.of(context).size.width - 40,
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: ThemeColors.lightBlueSolid,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Amount Due',
                    style: TextStyle(
                        fontFamily: 'SourceSansPro',
                        color: ThemeColors.greyText,
                        fontSize: 10),
                  ),
                  Text(
                    '₦26,750.00',
                    style: TextStyle(fontFamily: sourceSansPro, fontSize: 24),
                  ),
                  Text(
                    'Loan taken on the 24th of July 2019',
                    style: TextStyle(
                        fontSize: 10,
                        fontFamily: roboto,
                        color: ThemeColors.greyText),
                  ),
                ],
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(top: 8, bottom: 3),
            width: 68,
            height: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(6)),
                color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  height: 15,
                  color: ThemeColors.orange50,
                  child: Center(
                    child: Text(
                      'DUE IN',
                      style: TextStyle(
                          fontSize: 10,
                          fontFamily: sourceSansPro,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Text(
                  '3',
                  style: TextStyle(
                      fontFamily: sourceSansPro, height: 1, fontSize: 32),
                ),
                Text(
                  'days',
                  style: TextStyle(
                      height: 1, fontFamily: sourceSansPro, fontSize: 10),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget CompleteVerificationSection() {
    return Container(
      height: 600,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 10),
            child: Text(
              'Complete verification',
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: roboto,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    padding: EdgeInsets.all(20),
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                              color: ThemeColors.lightBlue10,
                              offset: Offset(0, 2),
                              spreadRadius: 1,
                              blurRadius: 5)
                        ]),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              '40%',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontFamily: roboto,
                                  fontSize: 20),
                            ),
                            Text(
                              '2 of 5 completed',
                              style: TextStyle(
                                  fontFamily: sourceSansPro,
                                  fontSize: 12,
                                  color: ThemeColors.darkText),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        LayoutBuilder(
                          builder: (context, constraint) {
                            return Stack(
                              children: <Widget>[
                                Container(
                                  height: 7,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4))),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 1),
                                  height: 5,
                                  width: (constraint.maxWidth * 40 / 100),
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: _colors,
                                        stops: _stops,
                                      ),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4))),
                                ),
                              ],
                            );
                          },
                        ),
                        ListDivider(
                          height: 0.5,
                          margin: EdgeInsets.symmetric(vertical: 20),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Container(
                                  height: 34,
                                  width: 34,
                                  decoration: BoxDecoration(
                                      color: ThemeColors.lightBlueSolid,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8))),
                                  child: Center(
                                    child: Image.asset(
                                        'assets/drawable-xxxhdpi/bank_blue.png',
                                        width: 20,
                                        height: 20,
                                        fit: BoxFit.fill),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Bank Account Details',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: roboto,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Input Bank details, i.e. name of bank, bank account number, etc.',
                                    style: TextStyle(
                                      fontFamily: sourceSansPro,
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                      height: 1.5,
                                      color: ThemeColors.darkBlue,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        ListDivider(
                          height: 0.5,
                          margin: EdgeInsets.symmetric(vertical: 20),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Container(
                                  height: 34,
                                  width: 34,
                                  decoration: BoxDecoration(
                                      color: ThemeColors.lightBlueSolid,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8))),
                                  child: Center(
                                    child: Image.asset(
                                      'assets/drawable-xxxhdpi/employment_blue.png',
                                      width: 20,
                                      height: 20,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Employment Information',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: roboto,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'We’ll require details of your work history and current employment.',
                                    style: TextStyle(
                                      fontFamily: sourceSansPro,
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                      height: 1.5,
                                      color: ThemeColors.darkBlue,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        ListDivider(
                          height: 0.5,
                          margin: EdgeInsets.symmetric(vertical: 20),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Container(
                                  height: 34,
                                  width: 34,
                                  decoration: BoxDecoration(
                                      color: ThemeColors.lightBlueSolid,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8))),
                                  child: Center(
                                    child: Image.asset(
                                        'assets/drawable-xxxhdpi/card_blue.png',
                                        width: 20,
                                        height: 20),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Billing Methods',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: roboto,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Add debit card(s) that will be used for loan repayment.',
                                    style: TextStyle(
                                      fontFamily: sourceSansPro,
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                      height: 1.5,
                                      color: ThemeColors.darkBlue,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    )),
              ]),
        ],
      ),
    );
  }

  List<Widget> renderScoreInfo(score) {
    var scoreData = [
      {
        "color": Colors.green,
        "caption": "833 - 900 EXCELLENT",
        "min_score": 833
      },
      {
        "color": Colors.blue,
        "caption": "790 - 832 VERY GOOD",
        "min_score": 790
      },
      {
        "color": ThemeColors.orangeIcon,
        "caption": "743 - 789 GOOD",
        "min_score": 743
      },
      {
        "color": ThemeColors.orangeMain,
        "caption": "693 - 742 FAIR",
        "min_score": 693
      },
      {
        "color": ThemeColors.redText,
        "caption": "633 - 692 NEED IMPROVEMENT",
        "min_score": 633
      },
    ];
    var scoreDataMap = scoreData.asMap();
    var scoreIndex = 0;
    for (var i = 0; i < scoreData.length; i++) {
      if (score > scoreData[i]["min_score"]) {
        scoreIndex = i;
        break;
      }
    }
    return scoreDataMap
        .map((index, element) => MapEntry(
            index,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 6,
                  width: 20,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(3)),
                      color: element["color"]),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  element["caption"],
                  style: TextStyle(
                      fontWeight: scoreIndex == index
                          ? FontWeight.bold
                          : FontWeight.normal,
                      fontFamily: sourceSansPro,
                      color: ThemeColors.darkText,
                      fontSize: 12),
                )
              ],
            )))
        .values
        .toList();
  }

  Widget DashboardItems(selectedIndex) {
    var data = [0, 1, 2];
    return Column(children: <Widget>[
      Material(
        color: ThemeColors.lightBlueSolid,
        child: InkWell(
          onTap: () {
            setState(() {
              selectedInfoIndex != 0
                  ? selectedInfoIndex = 0
                  : selectedInfoIndex = -1;
            });
          },
          child: ClipRRect(
            child: AnimatedContainer(
              duration: _duration,
              curve: _curves,
              height: selectedIndex == 0 ? 245 : 70,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: OverflowBox(
                  alignment: Alignment.topCenter,
                  maxHeight: 265,
                  minHeight: 265,
                  child: Column(
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                height: 34,
                                width: 34,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                                child: Center(
                                  child: Image.asset(
                                      'assets/drawable-xxxhdpi/score_factors_blue.png',
                                      width: 20,
                                      height: 20),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Score factors',
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'SourceSansPro',
                                    fontSize: 14),
                              ),
                            ],
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Icon(
                              Icons.chevron_right,
                              color: ThemeColors.greyText,
                            ),
                          ),
                        ],
                      ),
                      ListDivider(
                        height: 0.5,
                        margin: EdgeInsets.symmetric(vertical: 15),
                      ),
                      Container(
                        child: Text(
                          'Using your Nodcredit account regulardly is an important part of building a healthy credit. We will be able to better evaluate your creditworthiness if there is more data about your spending behaviour on your credit.',
                          style: TextStyle(
                              fontFamily: sourceSansPro,
                              fontSize: 12,
                              color: ThemeColors.greyText,
                              height: 1.5),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      Material(
        color: ThemeColors.lightBlueSolid,
        child: InkWell(
          onTap: () {
            setState(() {
              selectedInfoIndex != 1
                  ? selectedInfoIndex = 1
                  : selectedInfoIndex = -1;
            });
          },
          child: ClipRRect(
            child: AnimatedContainer(
              duration: _duration,
              height: selectedIndex == 1 ? 245 : 70,
              curve: _curves,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: OverflowBox(
                  alignment: Alignment.topCenter,
                  maxHeight: 265,
                  minHeight: 265,
                  child: Column(
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                height: 34,
                                width: 34,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                                child: Center(
                                  child: Image.asset(
                                      'assets/drawable-xxxhdpi/where_i_stand_blue.png',
                                      width: 20,
                                      height: 20),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Where I stand',
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'SourceSansPro',
                                    fontSize: 14),
                              ),
                            ],
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Icon(
                              Icons.chevron_right,
                              color: ThemeColors.greyText,
                            ),
                          ),
                        ],
                      ),
                      ListDivider(
                        height: 0.5,
                        margin: EdgeInsets.symmetric(vertical: 15),
                      ),
                      Container(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          RichText(
                              text: TextSpan(
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: sourceSansPro,
                                      color: ThemeColors.greyText,
                                      fontWeight: FontWeight.bold),
                                  text: 'Your score (750) ',
                                  children: <TextSpan>[
                                TextSpan(
                                    text: 'is ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal)),
                                TextSpan(text: 'higher than 49.5% '),
                                TextSpan(
                                    text: 'of customers',
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal))
                              ])),
                          SizedBox(
                            height: 30,
                          ),
                          Column(
                            children: renderScoreInfo(750),
                          )
                        ],
                      )),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      Material(
        color: ThemeColors.lightBlueSolid,
        child: InkWell(
          onTap: () {
            setState(() {
              selectedInfoIndex != 2
                  ? selectedInfoIndex = 2
                  : selectedInfoIndex = -1;
            });
          },
          child: ClipRRect(
            child: AnimatedContainer(
              duration: _duration,
              curve: _curves,
              height: selectedIndex == 2 ? 245 : 70,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: OverflowBox(
                  alignment: Alignment.topCenter,
                  maxHeight: 265,
                  minHeight: 265,
                  child: Column(
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                height: 34,
                                width: 34,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                                child: Center(
                                  child: Image.asset(
                                      'assets/drawable-xxxhdpi/improve_blue.png',
                                      width: 13,
                                      height: 13),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Ways to improve my Nodscore',
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'SourceSansPro',
                                    fontSize: 14),
                              ),
                            ],
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Icon(
                              Icons.chevron_right,
                              color: ThemeColors.greyText,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Making loan repayments on time or early.',
                            style: TextStyle(
                                fontFamily: sourceSansPro,
                                fontSize: 12,
                                color: ThemeColors.greyText,
                                height: 1.5),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Completing your profile details: it hleps your score when we know as much as possible about you.',
                            style: TextStyle(
                                fontFamily: sourceSansPro,
                                fontSize: 12,
                                color: ThemeColors.greyText,
                                height: 1.5),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Using the pause option doesn't affect your score negatively.",
                            style: TextStyle(
                                fontFamily: sourceSansPro,
                                fontSize: 12,
                                color: ThemeColors.greyText,
                                height: 1.5),
                          ),
                        ],
                      )),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ]);
  }

  Widget TooltipSection() {
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: ThemeColors.lightBlue5),
      child: Row(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: ThemeColors.orangeIcon),
            height: 30,
            width: 30,
            child: Icon(
              Icons.lightbulb_outline,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: RichText(
              textAlign: TextAlign.justify,
              text: TextSpan(
                text:
                    'Credit / debit cards should be valid for at least 3 months and match your registered banking institution.',
                style: TextStyle(
                    fontSize: 12, height: 1.5, color: ThemeColors.darkBlue),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      appBar:
//          MainAppBar(context, 'Dashboard', false, _scaffoldKey)
          AppBarComponent(
        context: context,
        goBack: false,
        scaffoldKey: _scaffoldKey,
        title: "Dashboard",
      ),
      drawer: BorrowerDrawerWidget(context),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Container(
          height: double.infinity,
          color: ThemeColors.backgroundColor,
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Stack(
              children: <Widget>[
                AnimatedPositioned(
                  duration: _duration,
                  curve: Curves.easeInOut,
                  top: isExpanded ? 285 : 100,
                  left: 20,
                  child: AnimatedOpacity(
                    duration: _opacityDuration,
                    opacity: isExpanded ? 1 : 0,
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        width: screenWidth - 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            color: ThemeColors.lightBlueSolid),
                        child: DashboardItems(selectedInfoIndex)),
                  ),
                ),
                Positioned(
                  top: 20,
                  left: 20,
                  child: GestureDetector(
                    onTap: () {
                      print('tap container');
                      _scrollController.animateTo(0.0,
                          duration: _duration, curve: Curves.easeInOut);

                      setState(() {
                        isExpanded = !isExpanded;
                        selectedInfoIndex = -1;
                      });
                    },
                    child: AnimatedContainer(
                      padding: EdgeInsets.all(10),
                      width: isExpanded
                          ? MediaQuery.of(context).size.width - 40
                          : 103,
                      height: isExpanded ? 240 : 108,
                      duration: _duration,
                      curve: Curves.easeInOut,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          boxShadow: [
                            BoxShadow(
                                color: ThemeColors.lightBlue10,
                                offset: Offset(0, 3),
                                spreadRadius: 0,
                                blurRadius: 3)
                          ]),
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment(0, 0.25),
                            child: Container(
                              height: 120,
                              width: 100,
//                                color: Colors.yellow,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  AnimatedDefaultTextStyle(
                                    style: isExpanded
                                        ? TextStyle(
                                            color: ThemeColors.darkText,
                                            fontSize: 33,
                                            fontFamily: 'SourceSansPro')
                                        : TextStyle(
                                            color: ThemeColors.darkText,
                                            fontSize: 45,
                                            fontFamily: 'SourceSansPro'),
                                    duration: _duration,
                                    child: Text(
                                      "750",
                                    ),
                                  ),
                                  AnimatedContainer(
                                    duration: _duration,
                                    height: isExpanded ? 15 : 0,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      _scrollController.animateTo(0.0,
                                          duration: _duration,
                                          curve: Curves.easeInOut);

                                      setState(() {
                                        isExpanded = !isExpanded;
                                        selectedInfoIndex = -1;
                                      });
                                    },
                                    child: Container(
                                      height: 22,
                                      width: 84,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          color: ThemeColors.lightBlueSolid),
                                      child: Center(
                                          child: Text(
                                        'NOD SCORE',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w500),
                                      )),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          AnimatedOpacity(
                            duration: _duration,
                            opacity: isExpanded ? 1 : 0,
                            child: Align(
                              alignment: Alignment(0, 0.3),
                              child: Container(
                                constraints: BoxConstraints(
                                    maxHeight: 180, maxWidth: 250),
                                child: Stack(
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment(0, 0.3),
                                      child: Container(
                                        child: SleekCircularSlider(
                                          min: 100,
                                          max: 900,
                                          initialValue: 750,
                                          appearance: CircularSliderAppearance(
                                              size: 150,
                                              startAngle: 180,
                                              angleRange: 180,
                                              customColors: CustomSliderColors(
                                                  trackColor: Colors.grey[200],
                                                  dotColor:
                                                      ThemeColors.orangeMain,
                                                  shadowColor:
                                                      Colors.transparent,
                                                  progressBarColor:
                                                      ThemeColors.orangeMain),
                                              customWidths: CustomSliderWidths(
                                                  trackWidth: 3,
                                                  progressBarWidth: 3,
                                                  handlerSize: 4.5,
                                                  shadowWidth: 0)),
                                          innerWidget: (double value) {
                                            // use your custom widget inside the slider (gets a slider value from the callback)
                                          },
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment(0, 0.2),
                                      child: Container(
                                        width: 160,
                                        height: 20,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              '100',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontFamily: sourceSansPro),
                                            ),
                                            Text(
                                              '900',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontFamily: sourceSansPro),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          AnimatedOpacity(
                              duration: _duration,
                              opacity: isExpanded ? 1 : 0,
                              child: Align(
                                  alignment: Alignment.topRight,
                                  child: Icon(
                                    Icons.keyboard_arrow_up,
                                    size: 30,
                                  ))),
                          AnimatedOpacity(
                              duration: _duration,
                              opacity: isExpanded ? 1 : 0,
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: RichText(
                                      text: TextSpan(
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontFamily: sourceSansPro,
                                              color: ThemeColors.darkText,
                                              fontWeight: FontWeight.bold),
                                          text: 'Updated: ',
                                          children: <TextSpan>[
                                        TextSpan(
                                            text: '1st July, 2019',
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal)),
                                      ])),
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
                AnimatedPositioned(
                  duration: _duration,
                  right: isExpanded ? -(screenWidth - 140) : 0,
                  child: AnimatedOpacity(
                    opacity: isExpanded ? 0 : 1,
                    duration: _opacityDuration,
                    child: Container(
                      padding: EdgeInsets.only(left: 20, top: 20),
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 120,
                          ),
                          Container(
                            height: 108,
                            width: screenWidth - 140,
                            padding: EdgeInsets.only(
                                top: 8, left: 12.5, bottom: 8, right: 20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(10)),
                                color: ThemeColors.lightBlueSolid),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      'Total Received',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: ThemeColors.darkBlue,
                                          fontFamily: 'SourceSansPro'),
                                    ),
                                    Text(
                                      '₦57,630.00',
                                      style: TextStyle(
                                          fontFamily: 'SourceSansPro'),
                                    ),
                                  ],
                                ),
                                ListDivider(
                                  height: 0.5,
                                  margin: EdgeInsets.all(0),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      'Completed Loans',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: ThemeColors.greenText,
                                          fontFamily: 'SourceSansPro'),
                                    ),
                                    Text(
                                      '1',
                                      style: TextStyle(
                                          fontFamily: 'SourceSansPro'),
                                    ),
                                  ],
                                ),
                                ListDivider(
                                  height: 0.5,
                                  margin: EdgeInsets.all(0),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      'Rejected Loans',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: ThemeColors.redText,
                                          fontFamily: 'SourceSansPro'),
                                    ),
                                    Text(
                                      '3',
                                      style: TextStyle(
                                          fontFamily: 'SourceSansPro'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                AnimatedPositioned(
                  duration: _duration,
                  curve: Curves.easeInOut,
                  top: isExpanded ? screenHeight : 160,
                  child: AnimatedOpacity(
                      duration: _opacityDuration,
                      opacity: isExpanded ? 0 : 1,
                      child: AmountDueSection()),
                ),
                AnimatedPositioned(
                  duration: _duration,
                  curve: Curves.easeInOut,
                  top: isExpanded ? screenHeight : 305,
                  child: AnimatedOpacity(
                    duration: _opacityDuration,
                    opacity: isExpanded ? 0 : 1,
                    child: CompleteVerificationSection(),
                  ),
                ),
                AnimatedPositioned(
                  duration: _duration,
                  curve: Curves.easeInOut,
                  top: isExpanded ? screenHeight : 705,
                  child: AnimatedOpacity(
                    duration: _opacityDuration,
                    opacity: isExpanded ? 0 : 1,
                    child: TooltipSection(),
                  ),
                ),
//                  AnimatedPositioned(
//                    duration: _duration,
//                    curve: Curves.easeInOut,
//                    top: isExpanded ? 305 : 100,
//                    left: 20,
//                    child: AnimatedOpacity(
//                      duration: _opacityDuration,
//                      opacity: isExpanded ? 1 : 0,
//                      child: Container(
//                          padding: EdgeInsets.symmetric(horizontal: 20),
//                          width: screenWidth - 40,
//                          decoration: BoxDecoration(
//                              borderRadius:
//                                  BorderRadius.all(Radius.circular(16)),
//                              color: ThemeColors.lightBlueSolid),
//                          child: DashboardItems(selectedInfoIndex)),
//                    ),
//                  ),
                isExpanded
                    ? Container(
                        height: 700,
                      )
                    : Container(
                        height: (850.0),
                      ),
              ],
            ),
          ), //        color: ThemeColors.backgroundBlue,
        ),
      ),
    );
  }
}

class ScoreElement {
  final Color color;
  final String caption;
  final int min_score;
  ScoreElement(this.color, this.caption, this.min_score);
}
