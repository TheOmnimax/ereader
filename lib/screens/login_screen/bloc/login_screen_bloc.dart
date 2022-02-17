import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ereader/constants/constants.dart';
import 'package:ereader/screens/login_screen/bloc/bloc.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ereader/bloc/bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    // on<Login>(_login);
    on<LoginError>(_loginError);
  }

  // Future _login(Login event, Emitter<LoginState> emit) async {
  //   final _auth = FirebaseAuth.instance;
  //   try {
  //     final userCredential = await _auth.signInWithEmailAndPassword(
  //         email: event.username, password: event.password);
  //     if (userCredential == null) {
  //       emit(state.copyWith(loginResult: LoginResult.unknownError));
  //     } else {
  //       emit(state.copyWith(loginResult: LoginResult.success));
  //       // TODO: What is the best way to close the screen?
  //       Navigator.pop(event.context);
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     switch (e.code) {
  //       case 'invalid-email':
  //         {
  //           emit(state.copyWith(loginResult: LoginResult.invalidEmail));
  //           break;
  //         }
  //       case 'user-disabled':
  //         {
  //           emit(state.copyWith(loginResult: LoginResult.disabled));
  //           break;
  //         }
  //       case 'user-not-found':
  //         {
  //           emit(state.copyWith(loginResult: LoginResult.notFound));
  //           break;
  //         }
  //       case 'wrong-password':
  //         {
  //           emit(state.copyWith(loginResult: LoginResult.invalidPassword));
  //           break;
  //         }
  //       default:
  //         {
  //           print(e.code);
  //           emit(state.copyWith(
  //             loginResult: LoginResult.unknownError,
  //             loginDetails: e.message,
  //           ));
  //         }
  //     }
  //   }
  // }

  void _loginError(LoginError event, Emitter<LoginState> emit) {
    print('Log in error');
    print(event.loginResult);
    emit(state.copyWith(
      loginResult: event.loginResult,
      loginDetails: event.loginDetails,
    ));
  }
}
