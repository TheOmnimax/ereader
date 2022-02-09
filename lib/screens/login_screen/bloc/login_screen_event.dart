import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class Login extends LoginEvent {
  const Login({
    required this.username,
    required this.password,
  });

  final String username;
  final String password;
}
