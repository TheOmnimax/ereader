import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ereader/constants/constants.dart';
import 'package:ereader/screens/registration_screen/bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ereader/shared_widgets/show_popup.dart';
import 'package:flutter/material.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc() : super(const RegistrationState()) {
    on<Register>(_register);
    on<RegisterError>(_registrationError);
  }

  Future _register(Register event, Emitter<RegistrationState> emit) async {
    final _auth = FirebaseAuth.instance;

    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
          email: event.username, password: event.password);
      if (userCredential == null) {
        emit(state.copyWith(registrationResult: LoginResult.unknownError));
      } else {
        await showPopup(
          context: event.context,
          title: 'Successful',
          buttons: <Widget>[
            TextButton(
              child: const Text('Yay!'),
              onPressed: () {
                Navigator.pop(event.context);
                Navigator.pop(event.context);
              },
            ),
          ],
          body: Text('Registration successful!'),
        );
        emit(state.copyWith(
          registrationResult: LoginResult.success,
          registrationDetails: '',
        ));
      }
    } on FirebaseAuthException catch (e) {
      // Errors can be found at https://firebase.google.com/docs/reference/js/v8/firebase.auth.Auth, with details at https://firebase.flutter.dev/docs/auth/error-handling/

      print('Code: ${e.code}');
      switch (e.code) {
        case 'invalid-email':
          {
            emit(state.copyWith(
              registrationResult: LoginResult.invalidEmail,
              registrationDetails: e.message,
            ));
            break;
          }
        case 'account-exists-with-different-credential':
        case 'credential-already-in-use':
        case 'email-already-in-use':
          {
            emit(state.copyWith(
              registrationResult: LoginResult.usedUsername,
              registrationDetails: '',
            ));
            break;
          }
        case 'weak-password':
          {
            emit(state.copyWith(
              registrationResult: LoginResult.invalidPassword,
              registrationDetails: e.message,
            ));
            break;
          }
        case 'account-exists-with-different-credential':
          {
            emit(state.copyWith(
              registrationResult: LoginResult.usedUsername,
            ));
            break;
          }
        default:
          {
            print('Error:');
            print(e);
            emit(state.copyWith(
              registrationResult: LoginResult.unknownError,
              registrationDetails: e.message,
            ));
            break;
          }
      }
    }
  }

  void _registrationError(
      RegisterError event, Emitter<RegistrationState> emit) {
    print('Emitting...');
    print(state.password2);
    emit(state.copyWith(
      registrationResult: event.registrationResult,
      registrationDetails: '',
    ));
  }
}
