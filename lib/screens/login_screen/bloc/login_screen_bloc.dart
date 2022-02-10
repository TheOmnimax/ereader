import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ereader/constants/constants.dart';
import 'package:ereader/screens/login_screen/bloc/bloc.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<Login>(_login);
  }

  Future _login(Login event, Emitter<LoginState> emit) async {
    final _auth = FirebaseAuth.instance;
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
          email: event.username, password: event.password);
      if (userCredential == null) {
        emit(state.copyWith(newResult: LoginResult.unknownError));
      } else {
        emit(state.copyWith(newResult: LoginResult.success));
        Navigator.pop(event.context);
      }
      // Navigator.pop(context);
    } catch (e) {
      print('Error:');
      print(e);
    }
  }
}
