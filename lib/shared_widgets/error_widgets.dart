import 'package:flutter/material.dart';
import 'package:ereader/constants/constants.dart';

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
          return Text('Success!');
        }
      case LoginResult.disabled:
        {
          return Text('Sorry, but this user has been disabled');
        }
      case LoginResult.invalidEmail:
        {
          return Text('Please enter a valid email address');
        }
      case LoginResult.wrongPassword:
        {
          return Text('Incorrect password');
        }
      case LoginResult.weakPassword:
        {
          return Text('Password too weak');
        }
      case LoginResult.missingEmail:
        {
          return Text('Please enter an email address');
        }
      case LoginResult.missingPassword:
        {
          return Text('Please enter a password');
        }
      case LoginResult.missingReenter:
        {
          return Text('Please re-enter your password');
        }
      case LoginResult.passwordMismatch:
        {
          return Text('Passwords do not match. Please retype them.');
        }
      case LoginResult.notFound:
        {
          return Text('Username not found');
        }
      case LoginResult.usedUsername:
        {
          return Text(
              'Username is already registered. Please either use a different email address, or reset your password.');
        }
      case LoginResult.unknownError:
        {
          return Text('Unknown error');
        }
      case LoginResult.brute:
        {
          return Text(
              'There were too many incorrect attempts to log in. Please try again later.');
        }
      default:
        {
          return Text('');
        }
    }
  }
}
