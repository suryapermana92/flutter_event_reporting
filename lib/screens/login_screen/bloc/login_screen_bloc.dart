// lib/blocs/login/login_bloc.dart
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:fluttersismic/global/bloc/authentication/authentication_bloc.dart';
import 'package:fluttersismic/global/bloc/authentication/bloc.dart';
import 'package:fluttersismic/global/services/auth.dart';
import 'package:fluttersismic/models/token.dart';
import 'package:fluttersismic/screens/login_screen/bloc/bloc.dart';
import 'package:fluttersismic/screens/login_screen/models/login_request.dart';
//import 'login_event.dart';
//import 'login_state.dart';
//import '../authentication/authentication.dart';
//import '../../exceptions/exceptions.dart';
//import '../../services/services.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationService _authenticationService;
  final AuthenticationBloc _authenticationBloc;

  LoginBloc(AuthenticationBloc authenticationBloc,
      AuthenticationService authenticationService)
      : assert(authenticationBloc != null),
        assert(authenticationService != null),
        _authenticationBloc = authenticationBloc,
        _authenticationService = authenticationService,
        super(LoginInitial());

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginInWithUserameAndPassword) {
      yield* _mapLoginWithEmailToState(event);
    }
  }

  Stream<LoginState> _mapLoginWithEmailToState(
      LoginInWithUserameAndPassword event) async* {
    yield LoginLoading();
    try {
      final response = await _authenticationService.signInWithEmailAndPassword(
          LoginFormData(username: event.username, password: event.password));
      if (response != null) {
        if (response.statusCode == 200) {
          yield LoginSuccess(responseMessage: 'Login Success');
          Token token = Token.fromJson(json.decode(response.body));
          String access_token = token.token;
          print(response.body);
//          yield LoginInitial();
          _authenticationBloc.add(UserLoggedIn(access_token: access_token));
        } else {
          yield LoginFailure(
              responseMessage: 'Login Failed: code ${response.statusCode}');
        }
        // push new authentication event

      } else {
        yield LoginFailure(
            responseMessage: 'Login Failed: code ${response.statusCode}');
      }
    } catch (err) {
      yield LoginFailure(
          responseMessage: err.message ?? 'An unknown error occured');
    }
  }
}
