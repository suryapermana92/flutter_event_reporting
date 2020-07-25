import 'package:flutter/material.dart';
import 'package:fluttersismic/styles/theme.dart';

import 'index.dart';

Widget InvestorDrawerWidget(context) {
  return Container(
    width: MediaQuery.of(context).size.width * 2 / 3,
    child: Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: Container(
        color: ThemeColors.backgroundColor,
        padding: EdgeInsets.only(right: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  height: 160,
                  width: double.infinity,
                  child: DrawerHeader(
                    padding: EdgeInsets.all(0),
                    child: Container(
                        child: Stack(
                      children: <Widget>[
                        Positioned(
                          right: -50,
                          bottom: -50,
                          child: Container(
                            height: 207,
                            width: 207,
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Opacity(
                                opacity: 0.1,
                                child: Image.asset(
                                  'assets/drawable-xxxhdpi/icon_white.png',
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  height: 26,
                                  width: 26,
                                  child: Image.asset(
                                    'assets/drawable-xxxhdpi/icon_white.png',
                                  ),
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Hello, Theodore!',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 22),
                                    ),
                                    GestureDetector(
                                      onTap: () {
//                                        Navigator.of(context)
//                                            .pushNamed(personalInformation);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: Text(
                                          'view your profile',
                                          style: TextStyle(
                                              color: ThemeColors.orangeMain,
                                              fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    )),
                    decoration: BoxDecoration(
                        color: ThemeColors.darkBlue,
                        border: Border(
                            bottom: BorderSide(color: Colors.grey[300]))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Material(
                    color: ThemeColors.backgroundColor,
                    child: InkWell(
                      onTap: () {},
                      child: ListTile(
                        leading: Container(
                            height: 34,
                            width: 34,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                color: ThemeColors.orange50),
                            child: Center(
                              child: Image.asset(
                                'assets/drawable-xxxhdpi/home_blue.png',
                                height: 15.25,
                              ),
                            )),
                        title: Text('Home'),
                      ),
                    ),
                  ),
                ),
                ListDivider(),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Material(
                    color: ThemeColors.backgroundColor,
                    child: InkWell(
                      onTap: () {
//                        Navigator.of(context).pushNamed(investmentScreen);
                      },
                      child: ListTile(
                        leading: Container(
                            height: 34,
                            width: 34,
                            decoration: BoxDecoration(
                              color: ThemeColors.lightBlue5,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            ),
                            child: Center(
                              child: Image.asset(
                                'assets/drawable-xxxhdpi/moneybag_blue.png',
                                height: 15.25,
                              ),
                            )),
                        title: Text('Investments'),
                      ),
                    ),
                  ),
                ),
                ListDivider(),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Material(
                    color: ThemeColors.backgroundColor,
                    child: InkWell(
                      onTap: () {
//                        Navigator.of(context).pushNamed(referralScreen);
                      },
                      child: ListTile(
                        leading: Container(
                            height: 34,
                            width: 34,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                color: ThemeColors.lightBlue5),
                            child: Center(
                              child: Image.asset(
                                'assets/drawable-xxxhdpi/refer_blue.png',
                                height: 15.25,
                              ),
                            )),
                        title: Text('Refer and Earn!'),
                      ),
                    ),
                  ),
                ),
                ListDivider(),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Material(
                    color: ThemeColors.backgroundColor,
                    child: InkWell(
                      onTap: () {
//                        Navigator.of(context).pushNamed(investorMoreScreen);
                      },
                      child: ListTile(
                        leading: Container(
                            height: 34,
                            width: 34,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                color: ThemeColors.lightBlue5),
                            child: Center(
                              child: Image.asset(
                                'assets/drawable-xxxhdpi/more_blue.png',
                                width: 15.25,
                              ),
                            )),
                        title: Text('More'),
                      ),
                    ),
                  ),
                ),
                ListDivider(),
                SizedBox(
                  height: 50,
                ),
                Material(
                  color: ThemeColors.lightBlue5,
                  child: InkWell(
                    onTap: () {
//                      Navigator.of(context).pushNamed(DashboardScreen);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: ListTile(
                        leading: Container(
                            height: 34,
                            width: 34,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            ),
                            child: Center(
                              child: Image.asset(
                                'assets/drawable-xxxhdpi/hand_card_blue.png',
                                height: 21,
                              ),
                            )),
                        title: RichText(
                          text: TextSpan(
                              text: 'Switch to ',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: ThemeColors.darkText,
                                  fontFamily: sourceSansPro),
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'Nodcredit Loans',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: ThemeColors.darkText))
                              ]),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                ListDivider(),
                SizedBox(
                  height: 10,
                ),
                ListTile(
                  onTap: () {
//                    Auth().removeToken();
//                    Navigator.of(context).pushNamed(loginScreen);
//                            Navigator.of(context)
//                                .popUntil(ModalRoute.withName(loginScreen));
                  },
                  title: Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Nodcredit V2.1',
                            textAlign: TextAlign.center,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 3),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                color: ThemeColors.greenActive),
                            child: Text(
                              'active',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10),
                            ),
                          )
                        ],
                      )),
                ),
                SizedBox(
                  height: 30,
                )
              ],
            )
          ],
        ),
      ),
    ),
  );
}

Widget BorrowerDrawerWidget(context) {
  return Container(
    width: MediaQuery.of(context).size.width * 2 / 3,
    child: Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: Container(
        color: ThemeColors.backgroundColor,
        padding: EdgeInsets.only(right: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  height: 160,
                  width: double.infinity,
                  child: DrawerHeader(
                    padding: EdgeInsets.all(0),
                    child: Container(
                        child: Stack(
                      children: <Widget>[
                        Positioned(
                          right: -50,
                          bottom: -50,
                          child: Container(
                            height: 207,
                            width: 207,
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Opacity(
                                opacity: 0.1,
                                child: Image.asset(
                                  'assets/drawable-xxxhdpi/icon_white.png',
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  height: 26,
                                  width: 26,
                                  child: Image.asset(
                                    'assets/drawable-xxxhdpi/icon_white.png',
                                  ),
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Hello, Theodore!',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 22),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      child: Text(
                                        'view your profile',
                                        style: TextStyle(
                                            color: ThemeColors.orangeMain,
                                            fontSize: 14),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    )),
                    decoration: BoxDecoration(
                        color: ThemeColors.darkBlue,
                        border: Border(
                            bottom: BorderSide(color: Colors.grey[300]))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Material(
                    color: ThemeColors.backgroundColor,
                    child: InkWell(
                      onTap: () {},
                      child: ListTile(
                        leading: Container(
                            height: 34,
                            width: 34,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                color: ThemeColors.orange50),
                            child: Center(
                              child: Image.asset(
                                'assets/drawable-xxxhdpi/home_blue.png',
                                height: 15.25,
                              ),
                            )),
                        title: Text('Home'),
                      ),
                    ),
                  ),
                ),
                ListDivider(),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Material(
                    color: ThemeColors.backgroundColor,
                    child: InkWell(
                      onTap: () {
//                        Navigator.of(context).pushNamed(borrowerScreen);
                      },
                      child: ListTile(
                        leading: Container(
                            height: 34,
                            width: 34,
                            decoration: BoxDecoration(
                              color: ThemeColors.lightBlue5,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            ),
                            child: Center(
                              child: Image.asset(
                                'assets/drawable-xxxhdpi/moneybag_blue.png',
                                height: 15.25,
                              ),
                            )),
                        title: Text('Loan'),
                      ),
                    ),
                  ),
                ),
                ListDivider(),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Material(
                    color: ThemeColors.backgroundColor,
                    child: InkWell(
                      onTap: () {
//                        Navigator.of(context).pushNamed(referralScreen);
                      },
                      child: ListTile(
                        leading: Container(
                            height: 34,
                            width: 34,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                color: ThemeColors.lightBlue5),
                            child: Center(
                              child: Image.asset(
                                'assets/drawable-xxxhdpi/refer_blue.png',
                                height: 15.25,
                              ),
                            )),
                        title: Text('Refer and Earn!'),
                      ),
                    ),
                  ),
                ),
                ListDivider(),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Material(
                    color: ThemeColors.backgroundColor,
                    child: InkWell(
                      onTap: () {
//                        Navigator.of(context).pushNamed(investorMoreScreen);
                      },
                      child: ListTile(
                        leading: Container(
                            height: 34,
                            width: 34,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                color: ThemeColors.lightBlue5),
                            child: Center(
                              child: Image.asset(
                                'assets/drawable-xxxhdpi/more_blue.png',
                                width: 15.25,
                              ),
                            )),
                        title: Text('More'),
                      ),
                    ),
                  ),
                ),
                ListDivider(),
                SizedBox(
                  height: 50,
                ),
                Material(
                  color: ThemeColors.lightBlue5,
                  child: InkWell(
                    onTap: () {
//                      Navigator.of(context).pushNamed(investorDashboardScreen);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: ListTile(
                        leading: Container(
                            height: 34,
                            width: 34,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            ),
                            child: Center(
                              child: Image.asset(
                                'assets/drawable-xxxhdpi/invest_graph_blue.png',
                                width: 20,
                              ),
                            )),
                        title: RichText(
                          text: TextSpan(
                              text: 'Invest with ',
                              style: TextStyle(
                                  fontSize: 14, color: ThemeColors.darkText),
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'Nodcredit',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: ThemeColors.darkText))
                              ]),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                ListDivider(),
                SizedBox(
                  height: 10,
                ),
                ListTile(
                  onTap: () {
//                            Navigator.of(context)
//                                .popUntil(ModalRoute.withName(loginScreen));
                  },
                  title: Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Nodcredit V2.1',
                            textAlign: TextAlign.center,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 3),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                color: ThemeColors.greenActive),
                            child: Text(
                              'active',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10),
                            ),
                          )
                        ],
                      )),
                ),
                SizedBox(
                  height: 30,
                )
              ],
            )
          ],
        ),
      ),
    ),
  );
}
