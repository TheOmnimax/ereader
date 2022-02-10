import 'package:equatable/equatable.dart';
import 'package:ereader/constants/constants.dart';
import 'package:flutter/material.dart';

abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  @override
  List<Object> get props => [];
}

class Register extends RegistrationEvent {
  const Register({
    this.username = '',
    this.password = '',
    required this.context,
  });

  final String username;
  final String password;
  final BuildContext context;
}

class RegisterError extends RegistrationEvent {
  const RegisterError({
    required this.registrationResult,
  });

  final LoginResult registrationResult;

  @override
  List<Object> get props => [registrationResult];
}
