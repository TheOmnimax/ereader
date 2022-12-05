part of 'login_screen_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.loginResult,
    this.loginDetails = '',
  });

  final LoginResult? loginResult;
  final String loginDetails;

  @override
  List<Object?> get props => [loginResult, loginDetails];

  LoginState copyWith({
    LoginResult? loginResult,
    String? loginDetails,
  }) {
    return LoginState(
      loginResult: loginResult ?? this.loginResult,
      loginDetails: loginDetails ?? '',
    );
  }
}
