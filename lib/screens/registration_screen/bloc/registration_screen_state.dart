import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ereader/constants/constants.dart';

class RegistrationState extends Equatable {
  const RegistrationState({
    this.username = '',
    this.password1 = '',
    this.password2 = '',
    this.registrationResult,
    this.registrationDetails = '',
  });

  final String username;
  final String password1;
  final String password2;
  final LoginResult? registrationResult;
  final String registrationDetails;

  @override
  List<Object?> get props => [
        username,
        password1,
        password2,
        registrationResult,
      ];

  RegistrationState copyWith({
    String? username,
    String? password1,
    String? password2,
    LoginResult? registrationResult,
    String? registrationDetails,
  }) {
    return RegistrationState(
      username: username ?? this.username,
      password1: password1 ?? this.password1,
      password2: password2 ?? this.password2,
      registrationResult: registrationResult ?? this.registrationResult,
      registrationDetails: registrationDetails ?? this.registrationDetails,
    );
  }
}
