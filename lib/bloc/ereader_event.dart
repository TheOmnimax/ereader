import 'package:ereader/shared_data/ereader_style.dart';
import 'package:ereader/constants/constants.dart';

abstract class AppEvent {
  AppEvent();
}

class AppOpened extends AppEvent {
  AppOpened();
}

class Login extends AppEvent {
  Login({
    required this.username,
    required this.password,
  });

  final String username;
  final String password;
}

class Logout extends AppEvent {
  Logout();
}

class Register extends AppEvent {
  Register({
    required this.username,
    required this.password1,
    required this.password2,
  });

  final String username;
  final String password1;
  final String password2;
}

class LoginError extends AppEvent {
  LoginError({
    this.loginResult,
    this.loginDetails,
  });

  final LoginResult? loginResult;
  final String? loginDetails;
}

class SelectStyle extends AppEvent {
  SelectStyle({
    required this.newStyle,
  });

  final EreaderStyle newStyle;
}

// class LoginError extends AppEvent {}
