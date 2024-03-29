import 'package:equatable/equatable.dart';
import 'package:ereader/constants/constants.dart';
import 'package:ereader/shared_data/ereader_style.dart';

class AppState extends Equatable {
  const AppState({
    required this.username,
    required this.currentStyle,
    required this.loginStatus,
    this.loginDetails,
  });

  final String username;
  final EreaderStyle currentStyle;
  final LoginResult loginStatus;
  final String? loginDetails;

  @override
  List<Object?> get props => [
        username,
        currentStyle,
        loginStatus,
        loginDetails,
      ];

  AppState copyWith({
    String? username,
    EreaderStyle? newStyle,
    LoginResult? loginStatus,
    String? loginDetails,
  }) {
    return AppState(
      username: username ?? this.username,
      currentStyle: newStyle ?? currentStyle,
      loginStatus: loginStatus ?? this.loginStatus,
      loginDetails: loginDetails,
    );
  }
}
