import 'package:fluttersismic/models/token.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthenticationEvent {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

// Fired just after the app is launched
class AppLoaded extends AuthenticationEvent {}

// Fired when a user has successfully logged in
class UserLoggedIn extends AuthenticationEvent {
  final String access_token;

  UserLoggedIn({@required this.access_token});

  @override
  List<Object> get props => [access_token];
}

// Fired when the user has logged out
class UserLoggedOut extends AuthenticationEvent {}
