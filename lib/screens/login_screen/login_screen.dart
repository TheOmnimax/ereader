import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ereader/constants/constants.dart';
import 'package:ereader/screens/login_screen/bloc/bloc.dart';
import 'package:ereader/shared_widgets/data_entry.dart';
import 'package:ereader/shared_widgets/shared_widgets.dart';

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
    var state = context.read<LoginBloc>().state;

    // Is this the best way to pop in a bloc refresh?
    if (state.loginResult == LoginResult.success) {
      Navigator.pop(context);
    }

    var username = '';
    var password = '';
    // TODO: Are these in the right place?

    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        // if (state.loginResult == LoginResult.success) {
        //   Navigator.pop(context);
        // }
        print('Refreshing');
        Text getLoginStatus() {
          print('Getting login status');
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
                              if (username == '') {
                                context.read<LoginBloc>().add(
                                      const LoginError(
                                        loginResult: LoginResult.missingEmail,
                                      ),
                                    );
                              } else if (!RegExp(kEmailRegex)
                                  .hasMatch(username)) {
                                context.read<LoginBloc>().add(
                                      const LoginError(
                                        loginResult: LoginResult.invalidEmail,
                                      ),
                                    );
                              } else if (password == '') {
                                context.read<LoginBloc>().add(
                                      const LoginError(
                                        loginResult:
                                            LoginResult.missingPassword,
                                      ),
                                    );
                              } else {
                                context.read<LoginBloc>().add(
                                      Login(
                                        username: username,
                                        password: password,
                                        context: context,
                                      ),
                                    );
                              }
                            },
                            child: Text('Log in'),
                          ),
                          LoginStatusWidget(
                            loginResult: state.loginResult,
                          ),
                          Text(state.loginDetails),
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
