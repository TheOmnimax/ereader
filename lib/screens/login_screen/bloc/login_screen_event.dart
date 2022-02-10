import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

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
}
