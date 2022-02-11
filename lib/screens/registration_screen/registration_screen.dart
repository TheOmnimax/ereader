import 'package:ereader/constants/constants.dart';
import 'package:ereader/screens/registration_screen/bloc/bloc.dart';
import 'package:ereader/shared_widgets/data_entry.dart';
import 'package:ereader/shared_widgets/shared_widgets.dart';
import 'package:ereader/shared_widgets/show_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationMain extends StatelessWidget {
  const RegistrationMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegistrationBloc(),
      child: const RegistrationScreen(),
    );
  }
}

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var username = '';
    var password1 = '';
    var password2 = '';
    return BlocBuilder<RegistrationBloc, RegistrationState>(
        builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Registration'),
        ),
        body: SafeArea(
          child: Align(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Register'),
                const SizedBox(
                  height: 10,
                ),
                Text('Register so you can save your settings to the cloud.'),
                const SizedBox(
                  height: 10,
                ),
                RoundedTextBox(
                  // controller: usernameController,
                  keyboard: TextInputType.emailAddress,
                  label: 'Email address',
                  onChanged: (value) {
                    username = value;
                    print('Updating username to: $username');
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                RoundedTextBox(
                  obscureText: true,
                  label: 'Password',
                  onChanged: (value) {
                    password1 = value;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                RoundedTextBox(
                  obscureText: true,
                  label: 'Re-enter password',
                  onChanged: (value) {
                    password2 = value;
                  },
                ),
                TextButton(
                  onPressed: () {
                    print('Testing username: $username');
                    print(RegExp(kEmailRegex).hasMatch(username));
                    if (username == '') {
                      context.read<RegistrationBloc>().add(
                            const RegisterError(
                              registrationResult: LoginResult.missingEmail,
                            ),
                          );
                    } else if (!RegExp(kEmailRegex).hasMatch(username)) {
                      print('Invalid email address');
                      context.read<RegistrationBloc>().add(
                            const RegisterError(
                              registrationResult: LoginResult.invalidEmail,
                            ),
                          );
                    } else if (password1 == '') {
                      context.read<RegistrationBloc>().add(
                            const RegisterError(
                              registrationResult: LoginResult.missingPassword,
                            ),
                          );
                    } else if (password2 == '') {
                      context.read<RegistrationBloc>().add(
                            const RegisterError(
                              registrationResult: LoginResult.missingReenter,
                            ),
                          );
                    } else if (password1 != password2) {
                      context.read<RegistrationBloc>().add(
                            const RegisterError(
                              registrationResult: LoginResult.passwordMismatch,
                            ),
                          );
                    } else {
                      // Actual registration
                      context.read<RegistrationBloc>().add(
                            Register(
                              username: username,
                              password: password1,
                              context: context,
                            ),
                          );
                    }
                  },
                  child: Text('Register'),
                ),
                LoginStatusWidget(
                  loginResult: state.registrationResult,
                ),
                Text(state.registrationDetails),
              ],
            ),
          ),
        ),
      );
    });
  }
}
