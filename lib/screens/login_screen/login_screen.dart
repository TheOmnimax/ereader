import 'package:ereader/bloc/bloc.dart';
import 'package:ereader/screens/login_screen/bloc/login_screen_bloc.dart';
import 'package:ereader/shared_widgets/data_entry.dart';
import 'package:ereader/shared_widgets/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginMain extends StatelessWidget {
  const LoginMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(),
      child: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<AppBloc>().add(LoginError());
    var username = '';
    var password = '';
    return Builder(
      builder: (context) {
        final appBloc = context.watch<AppBloc>();
        return BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            if (appBloc.state.username != '') {
              Navigator.pop(context);
            }

            return Scaffold(
              appBar: AppBar(
                title: const Text('Log in'),
              ),
              body: SafeArea(
                child: Column(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.popAndPushNamed(context, '/register');
                      },
                      child: const Align(
                        alignment: Alignment.topRight,
                        child: Text('Register'),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 35),
                        child: Align(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Text('Log in'),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                'Log in so you can save your settings to the cloud.',
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              RoundedTextBox(
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
                                  password = value;
                                },
                              ),
                              TextButton(
                                onPressed: () {
                                  context.read<AppBloc>().add(
                                        Login(
                                          username: username,
                                          password: password,
                                        ),
                                      );
                                },
                                child: const Text('Log in'),
                              ),
                              LoginStatusWidget(
                                loginResult: appBloc.state.loginStatus,
                              ),
                              Text(appBloc.state.loginDetails ?? ''),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
