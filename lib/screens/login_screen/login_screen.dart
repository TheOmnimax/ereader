import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ereader/constants/constants.dart';
import 'package:ereader/screens/login_screen/bloc/bloc.dart';
import 'package:ereader/shared_widgets/data_entry.dart';

class LoginMain extends StatelessWidget {
  const LoginMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(),
      child: const LoginScreen(),
      // TODO: Does this have to be separate, or can it be within the same widget?
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var username = '';
    var password = '';
    // TODO: Are these in the right place?

    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        Text getLoginStatus() {
          switch (state.loginResult) {
            case LoginResult.success:
              {
                return Text('Success');
              }
            case LoginResult.unknownError:
              {
                return Text('Invalid credentials');
              }
            default:
              {
                return Text('');
              }
          }
        }

        return Scaffold(
          appBar: AppBar(
            title: Text('Log in'),
          ),
          body: SafeArea(
            child: Column(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.popAndPushNamed(context, '/register');
                  },
                  child: Align(
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
                          Text('Log in'),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                              'Log in so you can save your settings to the cloud.'),
                          SizedBox(
                            height: 10,
                          ),
                          RoundedTextBox(
                            keyboard: TextInputType.emailAddress,
                            label: 'Email address',
                            onChanged: (value) {
                              username = value;
                            },
                          ),
                          SizedBox(
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
                              context.read<LoginBloc>().add(
                                    Login(
                                      username: username,
                                      password: password,
                                    ),
                                  );
                            },
                            child: Text('Log in'),
                          ),
                          getLoginStatus(),
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
  }
}
