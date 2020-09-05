import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:fluttersismic/global/services/auth.dart';
import 'package:fluttersismic/models/user.dart';
import 'package:fluttersismic/utils/jwt_decoder.dart';
import './bloc.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationService _authenticationService;

  AuthenticationBloc(AuthenticationService authenticationService)
      : assert(authenticationService != null),
        _authenticationService = AuthenticationService(),
        super(AuthenticationInitial());

  @override
  AuthenticationState get initialState => AuthenticationInitial();

  Stream<AuthenticationState> _mapAppLoadedToState(AppLoaded event) async* {
    yield AuthenticationLoading(); // to display splash screen
    try {
      await Future.delayed(Duration(milliseconds: 500)); // a simulated delay
      final accessToken = await _authenticationService.getCurrentUser();

      if (accessToken != null) {
        bool isTokenExpired = JwtService.isExpired(accessToken);

        if (isTokenExpired) {
          yield* _mapUserLoggedOutToState();
          return;
        }
        yield AuthenticationAuthenticated(token: accessToken);
      } else {
        yield AuthenticationNotAuthenticated();
      }
    } catch (e) {
      yield AuthenticationFailure(
          message: e.message ?? 'An unknown error occurred');
    }
  }

  Stream<AuthenticationState> _mapUserLoggedInToState(
      UserLoggedIn event) async* {
    String accessToken = event.access_token;
    await _authenticationService.saveCurrentUser(accessToken);
    yield AuthenticationAuthenticated(token: accessToken);
  }

  Stream<AuthenticationState> _mapUserLoggedOutToState() async* {
    await _authenticationService.signOut();
    yield AuthenticationNotAuthenticated();
  }

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    // TODO: Add Logic
    if (event is AppLoaded) {
      yield* _mapAppLoadedToState(event);
    }

    if (event is UserLoggedIn) {
      yield* _mapUserLoggedInToState(event);
    }

    if (event is UserLoggedOut) {
      yield* _mapUserLoggedOutToState();
    }
  }
}

AuthenticationBloc authenticationBloc =
    AuthenticationBloc(authenticationService);
