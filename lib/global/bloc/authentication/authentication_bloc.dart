import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:fluttersismic/global/services/auth.dart';
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
      final accessToken = await AuthenticationService.getCurrentUser();

      if (accessToken != null) {
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
    await AuthenticationService.saveCurrentUser(accessToken);
    yield AuthenticationAuthenticated(token: accessToken);
  }

  Stream<AuthenticationState> _mapUserLoggedOutToState(
      UserLoggedOut event) async* {
    await AuthenticationService.signOut();
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
      yield* _mapUserLoggedOutToState(event);
    }
  }
}

AuthenticationBloc authenticationBloc =
    AuthenticationBloc(authenticationService);
