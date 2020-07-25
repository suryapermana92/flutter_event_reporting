import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttersismic/screens/login_screen/bloc/bloc.dart';
import 'package:fluttersismic/screens/login_screen/models/login_request.dart';
import 'package:fluttersismic/styles/theme.dart';
import 'package:fluttersismic/utils/bubble_indication_painter.dart';
import 'package:fluttersismic/utils/route_generator.dart';
import 'dart:io';
import 'dart:async';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fluttersismic/styles/theme.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  GlobalKey signupCard = GlobalKey();
//  FirebaseAnalytics analytics = FirebaseAnalytics();
//
//  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final FocusNode myFocusNodeEmailLogin = FocusNode();
  final FocusNode myFocusNodePasswordLogin = FocusNode();

  final FocusNode myFocusNodePassword = FocusNode();
  final FocusNode myFocusNodeEmail = FocusNode();
  final FocusNode myFocusNodePhone = FocusNode();

  TextEditingController loginEmailController = new TextEditingController();
  TextEditingController loginPasswordController = new TextEditingController();

  bool _obscureTextLogin = true;
  bool _obscureTextSignup = true;
  bool _obscureTextSignupConfirm = true;

  String emailFieldErrorMessage = null;
  String passwordFieldErrorMessage = null;

  String _signupEmailErrorMessage = null;
  String _signupPasswordErrorMessage = null;
  String _versionNumber;
  String _buildNumber;

  bool _isLoading = false;

  bool acceptTerm = false;

  TextEditingController signupEmailController = new TextEditingController();
  TextEditingController signupPhoneController = new TextEditingController();
  TextEditingController signupPasswordController = new TextEditingController();

  PageController _pageController;

  Color left = Colors.black;
  Color right = Colors.white;

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,_;:\s@\!"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Email format is invalid';
    } else {
      return null;
    }
  }

  String pwdValidator(String value) {
    if (value.length < 6) {
      return 'Password must be longer than 6 characters';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    LoginBloc loginBloc = BlocProvider.of<LoginBloc>(context);

    return Scaffold(
      key: _scaffoldKey,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: new WillPopScope(
          onWillPop: () async {
            return true;
          },
          child: BlocConsumer<LoginBloc, LoginState>(
              bloc: loginBloc,
              listener: (context, state) {
                if (state is LoginSuccess) {
                  showInSnackBar(state.responseMessage);
                  Future.delayed(Duration(seconds: 1), () {
                    Navigator.of(context).pushReplacementNamed(dashboardScreen);
                  });
                } else if (state is LoginFailure) {
                  showInSnackBar(state.responseMessage);
                }
              },
              builder: (context, state) {
                return Container(
                  decoration: new BoxDecoration(
//                    color: ThemeColors.backgroundBlue

                    gradient: new LinearGradient(
                        colors: [ThemeColors.mediumGrey, ThemeColors.lightGrey],
                        begin: Alignment.bottomRight,
                        end: Alignment.topLeft,
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                  ),
                  child: SingleChildScrollView(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height >= 700.0
                          ? MediaQuery.of(context).size.height
                          : 775.0,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 70.0, bottom: 30),
                            child: new Image(
                                width: 170.0,
                                height: 130.0,
                                fit: BoxFit.contain,
                                image: new AssetImage(
                                    'assets/images/logo-placeholder.png')),
                          ),
//                    Padding(
//                      padding: EdgeInsets.only(top: 20.0),
//                      child: _buildMenuBar(context),
//                    ),
                          Expanded(
                            flex: 2,
                            child: PageView(
                              controller: _pageController,
                              onPageChanged: (i) {
                                if (i == 0) {
                                  setState(() {
                                    right = Colors.white;
                                    left = Colors.black;
                                  });
                                } else if (i == 1) {
                                  setState(() {
                                    right = Colors.black;
                                    left = Colors.white;
                                  });
                                }
                              },
                              children: <Widget>[
                                new ConstrainedBox(
                                  constraints: const BoxConstraints.expand(),
                                  child: _buildSignIn(context),
                                ),
//                          new ConstrainedBox(
//                            constraints: const BoxConstraints.expand(),
//                            child: _buildSignUp(context),
//                          ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }

  @override
  void dispose() {
    myFocusNodePassword.dispose();
    myFocusNodeEmail.dispose();
    myFocusNodePhone.dispose();
    _pageController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    _pageController = PageController();
  }

  void showInSnackBar(String value) {
    FocusScope.of(context).requestFocus(new FocusNode());
    _scaffoldKey.currentState?.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontFamily: "WorkSansSemiBold"),
      ),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 5),
    ));
  }

  bool validateLoginForm() {
    var email = loginEmailController.text;
    var password = loginPasswordController.text;
    var isEmailValid = email.length > 0;
    var isPasswordValid = password.length > 0;
    bool isValid = false;
    setState(() {
      emailFieldErrorMessage = isEmailValid ? null : 'Please enter username';
    });
    setState(() {
      passwordFieldErrorMessage = isEmailValid ? null : 'Please enter password';
    });
    if (isEmailValid && isPasswordValid) {
      isValid = true;
    }
    return isValid;
  }

  bool validateSignupForm() {
    var email = signupEmailController.text;
    var password = signupPasswordController.text;
    var isEmailValid =
        RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
    String pattern = r'^(?=.*[0-9])(?=.*[a-zA-Z])([a-zA-Z0-9]+)$';
    RegExp regExp = new RegExp(pattern);

    var isPasswordValid = regExp.hasMatch(password) && password.length > 7;
    bool isValid = false;
    if (isEmailValid == true) {
      setState(() {
        _signupEmailErrorMessage = null;
      });
    } else {
      setState(() {
        _signupEmailErrorMessage = 'Invalid email format';
      });
    }
    if (isPasswordValid) {
      setState(() {
        _signupPasswordErrorMessage = null;
      });
    } else {
      setState(() {
        _signupPasswordErrorMessage = 'Min. 8 characters and alphanumeric';
      });
    }
    if (isEmailValid && isPasswordValid) {
      isValid = true;
    }
    return isValid;
  }

  Widget _buildMenuBar(BuildContext context) {
    return Container(
      width: 250.0,
      height: 50.0,
      decoration: BoxDecoration(
        color: Color(0x552B2B2B),
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
      child: CustomPaint(
        painter: TabIndicationPainter(pageController: _pageController),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: _onSignInButtonPress,
                child: Text(
                  "Log in",
                  style: TextStyle(
                      color: left,
                      fontSize: 16.0,
                      fontFamily: "WorkSansSemiBold"),
                ),
              ),
            ),
            //Container(height: 33.0, width: 1.0, color: Colors.white),
            Expanded(
              child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: _onSignUpButtonPress,
                child: Text(
                  "Sign up",
                  style: TextStyle(
                      color: right,
                      fontSize: 16.0,
                      fontFamily: "WorkSansSemiBold"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignIn(BuildContext context) {
    LoginBloc loginBloc = BlocProvider.of<LoginBloc>(context);
    const TextStyle defaultTextStyle =
        TextStyle(color: Colors.black, fontSize: 14);
    return BlocBuilder<LoginBloc, LoginState>(
      bloc: loginBloc,
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.only(top: 23.0),
          child: Column(
            children: <Widget>[
              Stack(
                alignment: Alignment.topCenter,
                overflow: Overflow.visible,
                children: <Widget>[
                  Card(
                    elevation: 2.0,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Container(
                      width: 300.0,
//                  height: 190.0,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                top: 20.0,
                                bottom: 20.0,
                                left: 25.0,
                                right: 25.0),
                            child: TextField(
                              focusNode: myFocusNodeEmailLogin,
                              controller: loginEmailController,
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(
                                  fontFamily: "WorkSansSemiBold",
                                  fontSize: 16.0,
                                  color: Colors.black),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                icon: Icon(
                                  FontAwesomeIcons.envelope,
                                  color: Colors.black,
                                  size: 22.0,
                                ),
                                hintText: "Email Address",
                                errorText: emailFieldErrorMessage,
                                hintStyle: TextStyle(
                                    fontFamily: "WorkSansSemiBold",
                                    fontSize: 17.0),
                              ),
                            ),
                          ),
                          Container(
                            width: 250.0,
                            height: 1.0,
                            color: Colors.grey[400],
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 20.0,
                                bottom: 20.0,
                                left: 25.0,
                                right: 25.0),
                            child: TextField(
                              focusNode: myFocusNodePasswordLogin,
                              controller: loginPasswordController,
                              obscureText: _obscureTextLogin,
                              style: TextStyle(
                                  fontFamily: "WorkSansSemiBold",
                                  fontSize: 16.0,
                                  color: Colors.black),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                icon: Icon(
                                  FontAwesomeIcons.lock,
                                  size: 22.0,
                                  color: Colors.black,
                                ),
                                hintText: "Password",
                                errorText: passwordFieldErrorMessage,
                                hintStyle: TextStyle(
                                    fontFamily: "WorkSansSemiBold",
                                    fontSize: 17.0),
                                suffixIcon: GestureDetector(
                                  onTap: _toggleLogin,
                                  child: Icon(
                                    _obscureTextLogin
                                        ? FontAwesomeIcons.eye
                                        : FontAwesomeIcons.eyeSlash,
                                    size: 15.0,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.4),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                padding:
                    EdgeInsets.only(top: 20, right: 20, bottom: 20, left: 5),
                width: double.infinity,
                child: Row(
                  children: <Widget>[
                    Checkbox(
                      value: acceptTerm,
                      onChanged: (bool value) {
                        setState(() {
                          acceptTerm = value;
                        });
                      },
                    ),
                    Expanded(
                        child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          _showSimpleDialog();
                        },
                        child: Container(
                            padding: EdgeInsets.only(right: 10),
                            child: RichText(
                              textAlign: TextAlign.justify,
                              text: TextSpan(children: [
                                TextSpan(
                                    text:
//                                    'By pressing "Sign Up" below, I have read and understood the',
                                        'By pressing "Log In" below, I have read and understood the',
                                    style: defaultTextStyle),
                                TextSpan(
                                    text: ' Terms and Conditions ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: ThemeColors.zurichBlue)),
                                TextSpan(
                                    text:
                                        'Disclaimer and Personal Information Collection Statement and agree to be bound by the same',
                                    style: defaultTextStyle),
                              ]),
                            )),
                      ),
                    )),
                  ],
                ),
              ),
              Column(
                children: <Widget>[
                  AnimatedContainer(
                    curve: Curves.easeOutQuint,
                    duration: Duration(milliseconds: 200),
                    padding: EdgeInsets.only(top: 20),
                    width: (state is LoginLoading || state is LoginSuccess)
                        ? 60
                        : 250,
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    child: SizedBox(
                      width: 250,
                      height: 50,
                      child: RaisedButton(
                          color: ThemeColors.zurichBlue,
                          splashColor: ThemeColors.appBarBlue,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0))),
                          child:
                              (state is LoginLoading || state is LoginSuccess)
                                  ? SizedBox(
                                      height: 25,
                                      width: 25,
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            new AlwaysStoppedAnimation<Color>(
                                                Colors.white),
                                      ),
                                    )
                                  : Text(
                                      "LOG IN",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25.0,
                                          fontFamily: "WorkSansBold"),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                          onPressed: () {
                            if (state is LoginLoading ||
                                state is LoginSuccess) {
                              return null;
                            } else {
                              var isValid = validateLoginForm();
                              if (isValid == false) {
                                return null;
                              } else {
                                print(
                                    '${loginEmailController.text}, ${loginPasswordController.text}');
                                if (acceptTerm != true) {
                                  showInSnackBar(
                                      "Please Accept our Terms and Conditions before proceed");
                                  return null;
                                } else {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  loginBloc.add(LoginInWithUserameAndPassword(
                                      username: loginEmailController.text,
                                      password: loginPasswordController.text));
                                }
                              }
                            }
                          }),
                    ),
                  ),
                ],
              ),
//          Padding(
//            padding: EdgeInsets.only(top: 10.0),
//            child: FlatButton(
//                onPressed: () {
////                  Navigator.of(context).pushNamed(forgotPasswordRoute);
//                },
//                child: Text(
//                  "Forgot Password?",
//                  style: TextStyle(
//                      decoration: TextDecoration.underline,
//                      color: Colors.white,
//                      fontSize: 16.0,
//                      fontFamily: "WorkSansMedium"),
//                )),
//          ),
              SizedBox(
                height: 10,
              ),
              Text('Version: $_versionNumber-$_buildNumber')
            ],
          ),
        );
      },
    );
  }

//  Future<bool> _readHasChangePassword() async {
//    final prefs = await SharedPreferences.getInstance();
//    final value = prefs.getBool('hasChangePassword') ?? null;
//    return value;
//  }

  Widget _buildSignUp(BuildContext context) {
    print(_isLoading);
    const TextStyle defaultTextStyle =
        TextStyle(color: Colors.black, fontSize: 14);
    return Container(
      padding: EdgeInsets.only(top: 23.0),
      child: ListView(
        padding: EdgeInsets.all(0),
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            overflow: Overflow.visible,
            children: <Widget>[
              Card(
                key: signupCard,
                elevation: 2.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  width: 300.0,
//                  height: 240.0,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextField(
                          onChanged: (val) {
                            var isEmailValid =
                                loginPasswordController.text.length > 0;
                            if (isEmailValid) {
                              setState(() {
                                _signupEmailErrorMessage = null;
                              });
                            }
                          },
                          focusNode: myFocusNodeEmail,
                          controller: signupEmailController,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.envelope,
                              color: Colors.black,
                            ),
                            hintText: "Username",
                            errorText: _signupEmailErrorMessage,
                            hintStyle: TextStyle(
                                fontFamily: "WorkSansSemiBold", fontSize: 16.0),
                          ),
                        ),
                      ),
                      Container(
                        width: 250.0,
                        height: 1.0,
                        color: Colors.grey[400],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextField(
                          onChanged: (val) {
                            var isPasswordValid = val.length > 5;
                            if (isPasswordValid) {
                              setState(() {
                                _signupPasswordErrorMessage = null;
                              });
                            }
                          },
                          focusNode: myFocusNodePassword,
                          controller: signupPasswordController,
                          obscureText: _obscureTextSignup,
                          style: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.lock,
                              color: Colors.black,
                            ),
                            hintText: "Password",
                            errorText: _signupPasswordErrorMessage,
                            hintStyle: TextStyle(
                                fontFamily: "WorkSansSemiBold", fontSize: 16.0),
                            suffixIcon: GestureDetector(
                              onTap: _toggleSignup,
                              child: Icon(
                                _obscureTextSignup
                                    ? FontAwesomeIcons.eye
                                    : FontAwesomeIcons.eyeSlash,
                                size: 15.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(30),
//            width: 280,
            child: Row(
              children: <Widget>[
                Checkbox(
                  value: acceptTerm,
                  onChanged: (bool value) {
                    setState(() {
                      acceptTerm = value;
                    });
                  },
                ),
                Expanded(
                    child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      _showSimpleDialog();
                    },
                    child: Container(
                        padding: EdgeInsets.only(right: 10),
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text:
                                    'By pressing "Sign Up" below, I have read and understood the',
                                style: defaultTextStyle),
                            TextSpan(
                                text: ' Terms and Conditions ',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: ThemeColors.zurichBlue)),
                            TextSpan(
                                text:
                                    'Disclaimer and Personal Information Collection Statement and agree to be bound by the same',
                                style: defaultTextStyle),
                          ]),
                        )),
                  ),
                )),
              ],
            ),
          ),
          AnimatedContainer(
            curve: Curves.easeOutQuint,
            duration: Duration(milliseconds: 200),
            padding: EdgeInsets.only(top: 20),
            width: _isLoading ? 60 : 250,
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: SizedBox(
              height: 50,
              child: RaisedButton(
                  color: ThemeColors.zurichBlue,
                  splashColor: ThemeColors.appBarBlue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0))),
                  child: _isLoading
                      ? SizedBox(
                          height: 25,
                          width: 25,
                          child: CircularProgressIndicator(
                            valueColor:
                                new AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Text(
                          "SIGN UP",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25.0,
                              fontFamily: "WorkSansBold"),
                          overflow: TextOverflow.ellipsis,
                        ),
                  onPressed: () {
                    if (_isLoading) {
                      return null;
                    } else {
                      var isValid = validateSignupForm();
                      if (isValid == false) {
                        return null;
                      } else {
                        if (acceptTerm != true) {
                          showInSnackBar(
                              "Please Accept our Terms and Conditions before proceed");
                          return null;
                        } else {
                          setState(() {
                            _isLoading = true;
                          });
                          var email = signupEmailController.text;
                          var password = signupPasswordController.text;
//                          Auth().handleSignUp(email, password).then((user) {
//                            setState(() {
//                              _isLoading = false;
//                            });
//                            if (user != null) {
//                              analytics.setUserId(user);
//
//                              Auth()
//                                  .setToken(
//                                  signupEmailController.text,
//                                  signupPasswordController.text,
//                                  _firebaseToken)
//                                  .then((res) {
//                                print(res.body);
//                              }).catchError((err) {
//                                print(err);
//                              });
//                              Navigator.of(context).pushNamed(navigationRoute);
//                            } else {
//                              print('failed');
//                              setState(() {
//                                _isLoading = false;
//                              });
//                            }
//                          }).catchError((e) {
//                            print(e);
//                            List<String> errors = e.toString().split(',');
//                            showInSnackBar("${errors[1]}");
//                            setState(() {
//                              _isLoading = false;
//                            });
//                          });
                        }
                      }
                    }
                  }),
            ),
          ),
        ],
      ),
    );
  }

  void _showSimpleDialog() {
    TextStyle bodyTextStyle = TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Colors.black,
        decoration: TextDecoration.none,
        fontFamily: "Roboto");

    TextStyle subTitleTextStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: ThemeColors.zurichBlue,
      decoration: TextDecoration.none,
      fontFamily: "Roboto",
    );
    TextStyle titleTextStyle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: ThemeColors.zurichBlue,
      decoration: TextDecoration.none,
      fontFamily: "Roboto",
    );

    showDialog(
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: CupertinoPopupSurface(
                child: Container(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Stack(
                  children: <Widget>[
                    Text(
                      'Terms & Conditions',
                      style: titleTextStyle,
                      textAlign: TextAlign.center,
                    ),
//                    ListView(
//                      children: <Widget>[
//                        Padding(
//                          padding: const EdgeInsets.all(8.0),
//                          child: Text(
//                            "HKGo",
//                            style: titleTextStyle,
//                            textAlign: TextAlign.center,
//                          ),
//                        ),
//                        Text(
//                          "Terms and Conditions, Disclaimer and Personal Information Collection Statement",
//                          style: subTitleTextStyle,
//                          textAlign: TextAlign.center,
//                        ),
//                        SizedBox(
//                          height: 15,
//                        ),
//                        Text(
//                          "A. Important Notice",
//                          style: subTitleTextStyle,
//                          textAlign: TextAlign.left,
//                        ),
//                        SizedBox(
//                          height: 15,
//                        ),
//                        Text(
//                          "1.	By installing, accessing and using HKGo (“App”), Users hereby accept and agree to be bound by the following Terms and Conditions, Disclaimer and Personal Information Collection Statement (“PICS”) of Zurich Services (Hong Kong) Limited (“the Company”, “we”, “our” or “Zurich”). The term “User/Users” refers to any individuals who, by any reason or purpose, use this App. If Users do not agree to these Terms and Conditions, Disclaimer and PICS, Users should uninstall this App immediately. The Company reserves the right to change, modify, add, or remove portions of the Terms and Conditions, Disclaimer and PICS at any time without prior notice to the Users. It is the Users’ responsibility from time-to-time to check these Terms and Conditions and Disclaimer periodically for changes or modification. The Users’ continued use of this App following the posting of changes or modifications will mean that Users accept any changes or modifications in the Terms and Conditions, Disclaimer and PICS.",
//                          style: bodyTextStyle,
//                          textAlign: TextAlign.justify,
//                        ),
//                        SizedBox(
//                          height: 15,
//                        ),
//                        Text(
//                          "B. Terms and Conditions",
//                          style: subTitleTextStyle,
//                          textAlign: TextAlign.left,
//                        ),
//                        SizedBox(
//                          height: 15,
//                        ),
//                        Text(
//                          '2.	We, through this App, provide Users with services, marketing and promotional information.  The services to be provided include but are not limited to provision of event information, information relating to navigation and real time traffic, parking real time information, information relating to call emergency road assistance and garage after sales and services (collectively “Services”).',
//                          style: bodyTextStyle,
//                          textAlign: TextAlign.justify,
//                        ),
//                        SizedBox(
//                          height: 10,
//                        ),
//                        Text(
//                          '3.	As long as Users perform and comply with these Terms and Conditions, we agree to grant Users a personal, non-exclusive, non-transferable, limited and revocable license to use this App for private and/or non-commercial purposes only. Unauthorized uses of this App are prohibited, including but not limited to the re-sale, transfer, modification or distribution of this App, or the text, graphics, music, barcodes, videos, information, hyperlinks and contents thereof, or any contents associated with this App.',
//                          style: bodyTextStyle,
//                          textAlign: TextAlign.justify,
//                        ),
//                        SizedBox(
//                          height: 10,
//                        ),
//                        Text(
//                          '4.	Users acknowledge and agree that they may be charged by their respective mobile service providers for network access or any such third party charges while using this App (including roaming charges). Users are fully responsible for any such charges that they may incur.',
//                          style: bodyTextStyle,
//                          textAlign: TextAlign.justify,
//                        ),
//                        SizedBox(
//                          height: 10,
//                        ),
//                        Text(
//                          '5.	All transmission contents and Users’ information used by the Users related to this App are restricted for designated purposes only. Users agree and accept that they shall comply with these terms and all relevant policies stipulated by us when using this App and any contents therein. We, at our sole discretion, reserve the right to terminate at any time the license granted to any Users without needing to provide any reasons. In the event that we believe that there is any breach or possible breach of these Terms & Conditions or Disclaimer or any other relevant policies stipulated by us, we are entitled to take legal actions against the Users who are in breach. If we do not act or have deferred action in relation to any breach, this does not mean that we have surrendered/waived our right to do so.',
//                          style: bodyTextStyle,
//                          textAlign: TextAlign.justify,
//                        ),
//                        SizedBox(
//                          height: 10,
//                        ),
//                        Text(
//                          '6.	We reserve the right to do any of the following, at any time, without notice or reasons (i) to remove this App for an indefinite period of time or cancel this App; (ii) to modify, suspend, interrupt or terminate operation of or access to this App, or any portion of this App whether to perform routine or non-routine maintenance, error correction, or other changes or otherwise; and (iii) to modify or change this App. Users acknowledge that we shall not be liable to any party for any or all of the actions referred to in this paragraph, or otherwise',
//                          style: bodyTextStyle,
//                          textAlign: TextAlign.justify,
//                        ),
//                        SizedBox(
//                          height: 15,
//                        ),
//                        Text(
//                          "Intellectual Property Rights",
//                          style: subTitleTextStyle,
//                          textAlign: TextAlign.left,
//                        ),
//                        SizedBox(
//                          height: 15,
//                        ),
//                        Text(
//                          '7.	Save for the logos and vouchers independently prepared by the relevant External Parties (as defined below), the content and materials available on this App, including but not limited to all texts, graphics, drawings, diagrams, photographs, map information materials and compilations of data or other materials (“Work”), are subject to intellectual property rights protection and the intellectual property rights of the Work are owned by the Company. Where any information or software is downloaded from this App, Users agree that they shall not copy or remove or obscure any copyright or other notices or legends contained in any such information or software.Except as expressly permitted herein or where prior written authorization is obtained from the Company, any reproduction, adaptation, distribution, redistribution, dissemination, modification, copying, uploading, transmission, retransmission, publication, commercial exploitation of the Work or making available of the Work to the public is strictly prohibited. You acknowledge that you do not acquire any intellectual property rights of the Company with regard to the App.',
//                          style: bodyTextStyle,
//                          textAlign: TextAlign.justify,
//                        ),
//                        SizedBox(
//                          height: 15,
//                        ),
//                        Text(
//                          "System Requirements",
//                          style: subTitleTextStyle,
//                          textAlign: TextAlign.left,
//                        ),
//                        SizedBox(
//                          height: 15,
//                        ),
//                        Text(
//                          '8.	Users must possess a mobile smart phone, mobile device or mobile network that is compatible, up to the configuration standards with Internet connectivity in order to use this App, which is compatible with mobile devices operated by Apple’s iOS12+ or Android 9+ which we, from time-to-time, may designate. These software requirements might be upgraded or changed time-to-time to stay compatible with functionality changes.',
//                          style: bodyTextStyle,
//                          textAlign: TextAlign.justify,
//                        ),
//                        SizedBox(
//                          height: 15,
//                        ),
//                        Text(
//                          "Termination",
//                          style: subTitleTextStyle,
//                          textAlign: TextAlign.left,
//                        ),
//                        SizedBox(
//                          height: 15,
//                        ),
//                        Text(
//                          '9.	We reserve the right to terminate the use of this App at any time without prior notice or reasons to Users.',
//                          style: bodyTextStyle,
//                          textAlign: TextAlign.justify,
//                        ),
//                        SizedBox(
//                          height: 15,
//                        ),
//                        Text(
//                          "Contracts (Rights of Third Parties) Ordinance",
//                          style: subTitleTextStyle,
//                          textAlign: TextAlign.left,
//                        ),
//                        SizedBox(
//                          height: 15,
//                        ),
//                        Text(
//                          '10.	A person who is not a party to this Agreement has no right under the Contracts (Rights of Third Parties) Ordinance (Cap. 623) (“Third Parties Ordinance”) to enforce or to enjoy the benefit of any term of this Agreement. For the avoidance of doubt, this provision shall not affect any right or remedy of a third party which exists, or is available apart from the Third Parties Ordinance.',
//                          style: bodyTextStyle,
//                          textAlign: TextAlign.justify,
//                        ),
//                        SizedBox(
//                          height: 15,
//                        ),
//                        Text(
//                          "Governing Law",
//                          style: subTitleTextStyle,
//                          textAlign: TextAlign.left,
//                        ),
//                        SizedBox(
//                          height: 15,
//                        ),
//                        Text(
//                          '11.	These Terms and Conditions shall be governed and construed in accordance with the laws of the Hong Kong Special Administrative Region. Users agree to submit to the exclusive jurisdiction of the Courts in the Hong Kong Special Administrative Region with respect to any legal proceedings that may arise in connection with this App, or a dispute as to the interpretation or breach of these Terms and Conditions.',
//                          style: bodyTextStyle,
//                          textAlign: TextAlign.justify,
//                        ),
//                        SizedBox(
//                          height: 15,
//                        ),
//                        Text(
//                          "C. Disclaimer",
//                          style: subTitleTextStyle,
//                          textAlign: TextAlign.left,
//                        ),
//                        SizedBox(
//                          height: 15,
//                        ),
//                        Text(
//                          '12.	This App and its contents are provided without warranty of any kind, either express or implied, and are subject to change without prior notice. We do not guarantee or warrant that the Users’ use of this App will be uninterrupted or error-free. We make no warranty whatsoever regarding non-infringement of third party’s rights, security, accuracy, completeness, merchantability, fitness for a particular purpose, or about the accuracy, reliability, completeness or timeliness of the contents, services, text, graphics and linkage to the App. Additionally, we do not guarantee that no viruses or other contaminating or destructive properties may be transmitted through this App, or that no damage will occur in the Users’ mobile smart phone or any other devices.',
//                          style: bodyTextStyle,
//                          textAlign: TextAlign.justify,
//                        ),
//                        SizedBox(
//                          height: 10,
//                        ),
//                        Text(
//                          '13.	Services are available to Users through the use of the App.  We have the right to limit the provision of the Services, including the period of time in which the Services are made available through this App, the size, placement and position of such Services, email messages or any other contents which are transmitted through this App. We reserve the right, at our sole discretion, to edit, modify, share, erase, delete or remove any of the Services posted on this App without any prior notice or reasons being given to Users. Users acknowledge that we shall not be liable to any party for any modification, suspension or discontinuance of the provision of the Services through this App or otherwise. ',
//                          style: bodyTextStyle,
//                          textAlign: TextAlign.justify,
//                        ),
//                        SizedBox(
//                          height: 10,
//                        ),
//                        Text(
//                          '14.	This App contains information contributed by others. A user may link from this App to hyperlinks, websites, resources, external information or any external application provided by others (“External Sources”). Access to and uses of the External Sources are entirely at the Users\' own risk and subject to any terms and conditions of the External Sources\' providers ("External Parties"). The hyperlinks in this App to these External Sources are provided merely for convenience purposes. The provision of External Sources shall not constitute any form of co-operation or affiliation between the Company and External Parties. Provision of, or assistance in providing, any such information on this application or links to External Sources gives rise to no statement, representation or warranty, express or implied, that the Company agrees or does not disagree with any such information or websites or applications.',
//                          style: bodyTextStyle,
//                          textAlign: TextAlign.justify,
//                        ),
//                        SizedBox(
//                          height: 10,
//                        ),
//                        Text(
//                          '15.	We accept no liability, obligation or responsibility whatsoever as to the accuracy, validity, fitness for a particular purpose, non-infringement, reliability, security, timeliness or freedom from computer virus in relation to any External Sources, and accepts no liability, obligation or responsibility whatsoever for any loss or damage whatsoever arising from or relating to any use or misuse of, or reliance on, or inability to use any External Sources.',
//                          style: bodyTextStyle,
//                          textAlign: TextAlign.justify,
//                        ),
//                        SizedBox(
//                          height: 10,
//                        ),
//                        Text(
//                          '16.	We reserve the right to terminate any links to External Sources at any time without notice or reasons. Unless otherwise expressly specified or agreed, we are not a party to any contractual arrangements entered into between the Users and the External Parties. ',
//                          style: bodyTextStyle,
//                          textAlign: TextAlign.justify,
//                        ),
//                        SizedBox(
//                          height: 10,
//                        ),
//                        Text(
//                          '17.	We (our officers, directors, employees, agents, representatives, shareholders, predecessors and successors) shall not be responsible or liable for any loss or damages or indemnifications (including by gross negligence) whatsoever and howsoever arising or resulting from or caused by (whether direct, indirect, special, consequential or incidental to) the installation, ability to use, inability to use or improper running of this App or contents being unable to be downloaded or lost internet connectivity or interruptions, delays, defects or omissions that may exist in the service, information, materials or other contents provided in this App or any external mobile applications or websites so hyperlinked to this App or their contents. Communications or transactions may be subject to interruption, transmission blackout, delayed or failed transmission and incorrect, erroneous, omitted or loss of data transmission. We will not be liable for malfunctions in communication facilities not under our control that may affect the matters in this clause. ',
//                          style: bodyTextStyle,
//                          textAlign: TextAlign.justify,
//                        ),
//                        SizedBox(
//                          height: 10,
//                        ),
//                        Text(
//                          '18.	Access to and uses of the External Sources are entirely at the Users\' own risk and subject to any terms and conditions of the External Parties. Users acknowledge that we do not control these External Sources and we will not be responsible for the privacy practices adopted by the External Parties. Users will be accessing these External Sources at their own risk. We strongly recommend that Users review and consider the privacy policies of these External Parties before accessing them.',
//                          style: bodyTextStyle,
//                          textAlign: TextAlign.justify,
//                        ),
//                        SizedBox(
//                          height: 10,
//                        ),
//                        Text(
//                          '19.	Users have the sole responsibility for ensuring adequate protection and back-up of data, information and/or equipment, and for undertaking appropriate precautions to scan for computer viruses or other destructive properties. ',
//                          style: bodyTextStyle,
//                          textAlign: TextAlign.justify,
//                        ),
//                        SizedBox(
//                          height: 15,
//                        ),
//                        Text(
//                          'Registration and Account Safety',
//                          style: subTitleTextStyle,
//                          textAlign: TextAlign.left,
//                        ),
//                        SizedBox(
//                          height: 15,
//                        ),
//                        Text(
//                          '20.	Users must register an account through the registration process ("Registration") to use the App.',
//                          style: bodyTextStyle,
//                          textAlign: TextAlign.justify,
//                        ),
//                        SizedBox(
//                          height: 10,
//                        ),
//                        Text(
//                          '21.	When registering as a user, Users agree that: ',
//                          style: bodyTextStyle,
//                          textAlign: TextAlign.justify,
//                        ),
//                        SizedBox(
//                          height: 10,
//                        ),
//                        Padding(
//                          padding: const EdgeInsets.only(left: 10),
//                          child: Text(
//                            'a.	They will not create an account for anyone other than themselves.',
//                            style: bodyTextStyle,
//                            textAlign: TextAlign.justify,
//                          ),
//                        ),
//                        Padding(
//                          padding: const EdgeInsets.only(left: 10),
//                          child: Text(
//                            'b.	They will select user names which reflect the actual identity/name of the Users for the Users\' account and which do not resemble any trademark or are offensive in nature or the like. We reserve the absolute right to remove or reclaim the same if we believe it is appropriate to do so (such as when the user name does not closely relate to the User\'s identity/actual name, when other trademark owners complain, or where the user name is offensive in nature or the like). ',
//                            style: bodyTextStyle,
//                            textAlign: TextAlign.justify,
//                          ),
//                        ),
//                        Padding(
//                          padding: const EdgeInsets.only(left: 10),
//                          child: Text(
//                            'c.	They will only create one account and keep Users\' contact information accurate and up-to-date. ',
//                            style: bodyTextStyle,
//                            textAlign: TextAlign.justify,
//                          ),
//                        ),
//                        Padding(
//                          padding: const EdgeInsets.only(left: 10),
//                          child: Text(
//                            'd.	They will not share their passwords or let anyone access their accounts or do anything that may jeopardize the security of their accounts. ',
//                            style: bodyTextStyle,
//                            textAlign: TextAlign.justify,
//                          ),
//                        ),
//                        Padding(
//                          padding: const EdgeInsets.only(left: 10),
//                          child: Text(
//                            'e.	They will not transfer their accounts to anyone without first obtaining our prior written permission. ',
//                            style: bodyTextStyle,
//                            textAlign: TextAlign.justify,
//                          ),
//                        ),
//                        Padding(
//                          padding: const EdgeInsets.only(left: 10),
//                          child: Text(
//                            'f.	They are responsible for safeguarding their passwords that they use to access the Services and for any activities or actions taken under their accounts. ',
//                            style: bodyTextStyle,
//                            textAlign: TextAlign.justify,
//                          ),
//                        ),
//                        Padding(
//                          padding: const EdgeInsets.only(left: 10),
//                          child: Text(
//                            'g.	We will not be liable for any loss or damage or damages or indemnification from Users\' failure to comply with all or any of the above, in particular, Users\' failure to safeguard their passwords resulting in third parties having access to their accounts.',
//                            style: bodyTextStyle,
//                            textAlign: TextAlign.justify,
//                          ),
//                        ),
//                        SizedBox(
//                          height: 15,
//                        ),
//                        Text(
//                          'Voucher',
//                          style: subTitleTextStyle,
//                          textAlign: TextAlign.left,
//                        ),
//                        SizedBox(
//                          height: 15,
//                        ),
//                        Text(
//                          '22.	Vouchers may from time-to-time be made available in the App at our sole discretion. However, this does not constitute any promise or obligation that we would be providing any vouchers at anytime in the future.',
//                          style: bodyTextStyle,
//                          textAlign: TextAlign.justify,
//                        ),
//                        SizedBox(
//                          height: 10,
//                        ),
//                        Text(
//                          '23.	We are not responsible for any loss or damage whatsoever arising from the use of or the inability to use the information and/or products and/or services offered by the merchants of the vouchers (“Merchants”). We accept no liability whatsoever in respect of the vouchers, nor do we give any views, opinions or advice in respect of any such products and/or services. ',
//                          style: bodyTextStyle,
//                          textAlign: TextAlign.justify,
//                        ),
//                        SizedBox(
//                          height: 10,
//                        ),
//                        Text(
//                          '24.	For all the products and/or services offered by the Merchants, the Merchants’ terms and conditions will apply and we will not be liable for any loss arising from the failure in any form by the merchants to provide services and/or products in accordance with the vouchers. In this regard, Users should refer to the specific terms and conditions of the Merchants and/or the terms and conditions of the vouchers, as the case may be.',
//                          style: bodyTextStyle,
//                          textAlign: TextAlign.justify,
//                        ),
//                        SizedBox(
//                          height: 15,
//                        ),
//                        Text(
//                          'D.	Personal Information Collection Statement',
//                          style: subTitleTextStyle,
//                          textAlign: TextAlign.left,
//                        ),
//                        SizedBox(
//                          height: 15,
//                        ),
//                        Text(
//                          '25.	The personal information of Users  collected or held by the Company from time to time, which also includes data collected or generated in the ordinary course of the Company’s business and the continuation of relationship with the User, may be used by Company and/or a company within its group (“Zurich Insurance Group”) for the following purposes necessary in providing services to the customers (“necessary purposes”) (otherwise the Company is unable to provide services to customers who fail to provide the required information):',
//                          style: bodyTextStyle,
//                          textAlign: TextAlign.justify,
//                        ),
//                        SizedBox(
//                          height: 10,
//                        ),
//                        Padding(
//                          padding: const EdgeInsets.only(left: 10),
//                          child: Text(
//                            'a)	to provide service information, include but are not limited to provision of event information, information relating to navigation and real time traffic, parking real time information, information relating to call emergency road assistance and garage after sales and services;',
//                            style: bodyTextStyle,
//                            textAlign: TextAlign.justify,
//                          ),
//                        ),
//                        Padding(
//                          padding: const EdgeInsets.only(left: 10),
//                          child: Text(
//                            'b)	to compile statistics or database or conduct market surveys or perform User analysis, profiling and segmentation undertaken by the Company and/or a company within the Zurich Insurance Group, respective regulators or industry recognized bodies, or to enhance existing or design new products and services of the Zurich Insurance Group; ',
//                            style: bodyTextStyle,
//                            textAlign: TextAlign.justify,
//                          ),
//                        ),
//                        Padding(
//                          padding: const EdgeInsets.only(left: 10),
//                          child: Text(
//                            'c)	to meet the disclosure requirements of any local or foreign law, rules, regulations, codes or guidelines binding on the Zurich Insurance Group and conduct matching procedures where necessary;',
//                            style: bodyTextStyle,
//                            textAlign: TextAlign.justify,
//                          ),
//                        ),
//                        Padding(
//                          padding: const EdgeInsets.only(left: 10),
//                          child: Text(
//                            'd)	to comply with the requirements, orders or legitimate requests of, or contractual or other commitment or arrangement with the courts of Hong Kong, local and foreign regulators, tax or law enforcement authority, self-regulatory or industry recognized bodies, including but not limited to auditors, governmental bodies and government-related establishments;',
//                            style: bodyTextStyle,
//                            textAlign: TextAlign.justify,
//                          ),
//                        ),
//                        Padding(
//                          padding: const EdgeInsets.only(left: 10),
//                          child: Text(
//                            'e)	to prevent and detect (and assist other companies within the Zurich Insurance Group to prevent and detect) fraud; and',
//                            style: bodyTextStyle,
//                            textAlign: TextAlign.justify,
//                          ),
//                        ),
//                        Padding(
//                          padding: const EdgeInsets.only(left: 10),
//                          child: Text(
//                            'f)	to facilitate the Company’s authorized service providers to provide services to the Company and/or the Users for the above purposes.',
//                            style: bodyTextStyle,
//                            textAlign: TextAlign.justify,
//                          ),
//                        ),
//                        SizedBox(
//                          height: 10,
//                        ),
//                        Text(
//                          '26.	Zurich may provide any personal information of Users to the following parties, within or outside of Hong Kong, for the necessary purposes:',
//                          style: bodyTextStyle,
//                          textAlign: TextAlign.justify,
//                        ),
//                        SizedBox(
//                          height: 10,
//                        ),
//                        Padding(
//                          padding: const EdgeInsets.only(left: 10),
//                          child: Text(
//                            'g)	any agent, contractor or third party service provider who provides administrative, telecommunications, technology, computer, payment, policy administration, support, storage, cloud, record management, call center, mailing and printing, data processing, User satisfaction analysis, outsourcing or other services to the Zurich Insurance Group in connection with the operation of its business.',
//                            style: bodyTextStyle,
//                            textAlign: TextAlign.justify,
//                          ),
//                        ),
//                        SizedBox(
//                          height: 10,
//                        ),
//                        Text(
//                          '27.	Customers’ personal information may from time to time be provided to any of the parties set out in paragraph 2 above (including cloud providers) which may be located in Hong Kong or elsewhere for necessary purposes and in this regard Users consent to the transfer of their personal information outside Hong Kong and understand that their personal data may not be protected to the same or similar level compared to Hong Kong.',
//                          style: bodyTextStyle,
//                          textAlign: TextAlign.justify,
//                        ),
//                        SizedBox(
//                          height: 10,
//                        ),
//                      ],
//                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        new RawMaterialButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.clear,
                            color: Colors.grey,
                            size: 30,
                          ),
//                          shape: new CircleBorder(),
//                          elevation: 2.0,
//                          fillColor: Colors.grey[200],
//                          padding: const EdgeInsets.all(5.0),
                          constraints: BoxConstraints.tight(Size(30, 30)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
//                  decoration: BoxDecoration(
//                      image: new DecorationImage(
//                        colorFilter: new ColorFilter.mode(Colors.white.withOpacity(0.4), BlendMode.dstATop),
//                        image: new AssetImage("assets/bg_motormech_1.png"),
//                        fit: BoxFit.cover,
//                      )
//                  ),
            )),
          );
        });
  }

  void _onSignInButtonPress() {
    _pageController.animateToPage(0,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _onSignUpButtonPress() {
    _pageController?.animateToPage(1,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _toggleLogin() {
    setState(() {
      _obscureTextLogin = !_obscureTextLogin;
    });
  }

  void _toggleSignup() {
    setState(() {
      _obscureTextSignup = !_obscureTextSignup;
    });
  }

  void _toggleSignupConfirm() {
    setState(() {
      _obscureTextSignupConfirm = !_obscureTextSignupConfirm;
    });
  }
}
