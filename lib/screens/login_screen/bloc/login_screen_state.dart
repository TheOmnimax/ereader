import 'package:equatable/equatable.dart';
import 'package:ereader/constants/constants.dart';
import 'package:ereader/screens/login_screen/bloc/bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.loginResult,
  });

  final LoginResult? loginResult;

  @override
  List<Object?> get props => [loginResult];

  LoginState copyWith({LoginResult? newResult}) {
    return LoginState(loginResult: newResult);
  }
}

// class LoginInitialState extends LoginState {
//   const LoginInitialState();
// }
//
// class LoggingInState extends LoginState {
//   const LoggingInState({});
// }
