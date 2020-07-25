// lib/blocs/login/login_state.dart

import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String responseMessage;

  LoginSuccess({@required this.responseMessage});

  @override
  List<Object> get props => [responseMessage];
}

class LoginFailure extends LoginState {
  final String responseMessage;

  LoginFailure({@required this.responseMessage});

  @override
  List<Object> get props => [responseMessage];
}
