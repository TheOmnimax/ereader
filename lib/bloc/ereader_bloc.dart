import 'dart:convert';

import 'package:ereader/bloc/ereader_event.dart';
import 'package:ereader/bloc/ereader_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ereader/shared_data/ereader_style.dart';
import '../constants/enums.dart';
import 'bloc.dart';
import 'package:ereader/file_explorer/files.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc()
      : super(
          AppState(
            username: '',
            currentStyle: const EreaderStyle(),
          ),
        ) {
    on<AppOpened>(_appOpened);
    on<Login>(_logIn);
    on<LogOut>(_logOut);
    on<Register>(_register);
    on<SelectStyle>(_selectStyle);
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FileReadWrite _styleRetriever =
      const FileReadWrite(relativePath: 'styles');
  final String _selectedStyleFile = 'selectedStyle.json';

  Future _appOpened(AppOpened event, Emitter<AppState> emit) async {
    final styleMap = await _styleRetriever.getFileAsMap(_selectedStyleFile);
    final selectedStyle = EreaderStyle.fromJson(styleMap);
    final currentUser = _auth.currentUser;
    final username = currentUser?.email ?? '';
    emit(AppState(username: username, currentStyle: selectedStyle));
  }

  Future _logIn(Login event, Emitter<AppState> emit) async {
    await _auth.signInWithEmailAndPassword(
        email: event.username, password: event.password);

    emit(state.copyWith(
      username: event.username,
    ));
  }

  Future _logOut(LogOut event, Emitter<AppState> emit) async {
    await _auth.signOut();
    emit(state.copyWith(
      username: '',
    ));
  }

  Future _register(Register event, Emitter<AppState> emit) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
          email: event.username, password: event.password);
      if (userCredential == null) {
        emit(state.copyWith(loginStatus: LoginResult.unknownError));
      } else {}
    } on FirebaseAuthException catch (e) {
      // Errors can be found at https://firebase.google.com/docs/reference/js/v8/firebase.auth.Auth, with details at https://firebase.flutter.dev/docs/auth/error-handling/

      print('Code: ${e.code}');
      switch (e.code) {
        case 'invalid-email':
          {
            emit(state.copyWith(
              loginStatus: LoginResult.invalidEmail,
              loginDetails: e.message,
            ));
            break;
          }
        case 'account-exists-with-different-credential':
        case 'credential-already-in-use':
        case 'email-already-in-use':
          {
            emit(state.copyWith(
              loginStatus: LoginResult.usedUsername,
              loginDetails: '',
            ));
            break;
          }
        case 'weak-password':
          {
            emit(state.copyWith(
              loginStatus: LoginResult.invalidPassword,
              loginDetails: e.message,
            ));
            break;
          }
        default:
          {
            print('Error:');
            print(e);
            emit(state.copyWith(
              loginStatus: LoginResult.unknownError,
              loginDetails: e.message,
            ));
            break;
          }
      }
    } catch (e) {
      print(e);
      emit(state.copyWith(
        loginStatus: LoginResult.unknownError,
        loginDetails: 'Uncaught error: $e',
      ));
    }
  }

  Future _selectStyle(SelectStyle event, Emitter<AppState> emit) async {
    final stringData = jsonEncode(event.newStyle.toJson());
    await _styleRetriever.writeString(
      filename: _selectedStyleFile,
      contents: stringData,
    );
    emit(state.copyWith(
      newStyle: event.newStyle,
    ));
  }
}
