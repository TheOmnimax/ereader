import 'package:ereader/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ereader/screens/registration_screen/bloc/bloc.dart';
import 'package:ereader/shared_widgets/data_entry.dart';
import 'package:ereader/shared_widgets/show_popup.dart';

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
    return BlocBuilder<RegistrationBloc, RegistrationState>(
        builder: (context, state) {
      if (state.registrationResult == RegistrationResult.success) {
        if (state.registrationResult == RegistrationResult.success) {}
      }

      var username = state.username;
      var password1 = state.password1;
      var password2 = state.password2;

      Text getRegStatus() {
        switch (state.registrationResult) {
          case RegistrationResult.success:
            {
              return Text('Success!');
            }
          case RegistrationResult.missingUsername:
            {
              return Text('Please enter an email address!');
            }
          case RegistrationResult.invalidEmail:
            {
              return Text('Please enter a valid email address');
            }
          case RegistrationResult.usedUsername:
            {
              return Text(
                  'Username is already registered. Please either use a different email address, or reset your password.');
            }
          case RegistrationResult.missingPassword:
            {
              return Text('Please enter a password');
            }
          case RegistrationResult.missingReenter:
            {
              return Text('Please re-enter your password');
            }
          case RegistrationResult.invalidPassword:
            {
              return Text('Invalid password');
            }
          case RegistrationResult.passwordMismatch:
            {
              return Text('Passwords do not match. Please retype them.');
            }
          case RegistrationResult.unknownError:
            {
              return Text('Unknown error');
            }
          default:
            {
              return Text('');
            }
        }
      }

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
                    context.read<RegistrationBloc>().add(
                          UpdateDetails(
                            username: username,
                          ),
                        );
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
                    context.read<RegistrationBloc>().add(
                          UpdateDetails(
                            password1: password1,
                          ),
                        );
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
                    context.read<RegistrationBloc>().add(
                          UpdateDetails(
                            password2: password2,
                          ),
                        );
                  },
                ),
                TextButton(
                  onPressed: () {
                    print('Testing username: $username');
                    print(RegExp(kEmailRegex).hasMatch(username));
                    if (username == '') {
                      context.read<RegistrationBloc>().add(
                            const RegisterError(
                              registrationResult:
                                  RegistrationResult.missingUsername,
                            ),
                          );
                    } else if (!RegExp(kEmailRegex).hasMatch(username)) {
                      print('Invalid email address');
                      context.read<RegistrationBloc>().add(
                            const RegisterError(
                              registrationResult:
                                  RegistrationResult.invalidEmail,
                            ),
                          );
                    } else if (password1 == '') {
                      context.read<RegistrationBloc>().add(
                            const RegisterError(
                              registrationResult:
                                  RegistrationResult.missingPassword,
                            ),
                          );
                    } else if (password2 == '') {
                      context.read<RegistrationBloc>().add(
                            const RegisterError(
                              registrationResult:
                                  RegistrationResult.missingReenter,
                            ),
                          );
                    } else if (password1 != password2) {
                      context.read<RegistrationBloc>().add(
                            const RegisterError(
                              registrationResult:
                                  RegistrationResult.passwordMismatch,
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
                getRegStatus(),
                Text(state.registrationDetails),
              ],
            ),
          ),
        ),
      );
    });
  }
}
