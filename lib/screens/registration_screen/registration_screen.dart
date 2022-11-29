import 'package:ereader/bloc/bloc.dart';
import 'package:ereader/screens/registration_screen/bloc/bloc.dart';
import 'package:ereader/shared_widgets/data_entry.dart';
import 'package:ereader/shared_widgets/shared_widgets.dart';
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
    final appBloc = context.watch<AppBloc>();
    context
        .read<AppBloc>()
        .add(LoginError()); // This is to clear any existing error messages
    var username = '';
    var password1 = '';
    var password2 = '';
    return BlocListener(
      listener: (BuildContext context, state) {
        if (appBloc.state.username != '') {
          Navigator.pop(context);
        }
      },
      child: BlocBuilder<RegistrationBloc, RegistrationState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Registration'),
            ),
            body: SafeArea(
              child: Align(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('Register'),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Register so you can save your settings to the cloud.',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    RoundedTextBox(
                      // controller: usernameController,
                      keyboard: TextInputType.emailAddress,
                      label: 'Email address',
                      onChanged: (value) {
                        username = value;
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
                        context.read<AppBloc>().add(
                              Register(
                                username: username,
                                password1: password1,
                                password2: password2,
                              ),
                            );
                      },
                      child: const Text('Register'),
                    ),
                    LoginStatusWidget(loginResult: appBloc.state.loginStatus),
                    Text(appBloc.state.loginDetails ?? ''),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );

    // context.read<AppBloc>().add(LoginError()); // Clear any current errors
  }
}
