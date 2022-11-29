import 'package:equatable/equatable.dart';
import 'package:ereader/constants/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_screen_event.dart';
part 'login_screen_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState());
}
