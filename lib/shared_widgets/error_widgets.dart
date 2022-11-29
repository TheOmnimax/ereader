import 'package:ereader/constants/constants.dart';
import 'package:flutter/material.dart';

class LoginStatusWidget extends StatelessWidget {
  const LoginStatusWidget({
    this.loginResult,
    Key? key,
  }) : super(key: key);

  final LoginResult? loginResult;

  @override
  Widget build(BuildContext context) {
    switch (loginResult) {
      case LoginResult.success:
        {
          return const Text('Success!');
        }
      case LoginResult.disabled:
        {
          return const Text('Sorry, but this user has been disabled');
        }
      case LoginResult.invalidEmail:
        {
          return const Text('Please enter a valid email address');
        }
      case LoginResult.wrongPassword:
        {
          return const Text('Incorrect password');
        }
      case LoginResult.weakPassword:
        {
          return const Text('Password too weak');
        }
      case LoginResult.missingEmail:
        {
          return const Text('Please enter an email address');
        }
      case LoginResult.missingPassword:
        {
          return const Text('Please enter a password');
        }
      case LoginResult.missingReenter:
        {
          return const Text('Please re-enter your password');
        }
      case LoginResult.passwordMismatch:
        {
          return const Text('Passwords do not match. Please retype them.');
        }
      case LoginResult.notFound:
        {
          return const Text('Username not found');
        }
      case LoginResult.usedUsername:
        {
          return const Text(
            'Username is already registered. Please either use a different email address, or reset your password.',
          );
        }
      case LoginResult.unknownError:
        {
          return const Text('Unknown error');
        }
      case LoginResult.brute:
        {
          return const Text(
            'There were too many incorrect attempts to log in. Please try again later.',
          );
        }
      case null:
        {
          return const Text('Unknown error');
        }
    }
  }
}
