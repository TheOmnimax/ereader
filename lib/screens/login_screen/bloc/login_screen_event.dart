import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:ereader/constants/constants.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class Login extends LoginEvent {
  const Login({
    required this.username,
    required this.password,
    required this.context,
  });

  final String username;
  final String password;
  final BuildContext context;

  @override
  List<Object> get props => [username, password, context];
}

class LoginError extends LoginEvent {
  const LoginError({
    required this.loginResult,
  });

  final LoginResult loginResult;

  @override
  List<Object> get props => [loginResult];
}
