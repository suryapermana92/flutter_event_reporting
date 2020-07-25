// lib/blocs/login/login_event.dart

import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginInWithUserameAndPassword extends LoginEvent {
  final String username;
  final String password;

  LoginInWithUserameAndPassword(
      {@required this.username, @required this.password});

  @override
  List<Object> get props => [username, password];
}
