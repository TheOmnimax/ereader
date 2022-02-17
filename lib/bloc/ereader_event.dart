import 'package:equatable/equatable.dart';
import 'package:ereader/shared_data/ereader_style.dart';

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

class LogOut extends AppEvent {
  LogOut();
}

class Register extends AppEvent {
  Register({
    required this.username,
    required this.password,
  });

  final String username;
  final String password;
}

class SelectStyle extends AppEvent {
  SelectStyle({
    required this.newStyle,
  });

  final EreaderStyle newStyle;
}

// class LoginError extends AppEvent {}
