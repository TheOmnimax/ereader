import 'package:ereader/constants/constants.dart';
import 'package:ereader/screens/ebook_selection_screen/bloc/bloc.dart';
import 'package:ereader/screens/login_screen/bloc/bloc.dart';
import 'package:ereader/shared_widgets/data_entry.dart';
import 'package:ereader/shared_widgets/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ereader/bloc/bloc.dart';

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
    final appBloc = context.watch<AppBloc>();

    var loginStatus = appBloc.state.loginStatus;
    var loginDetails = appBloc.state.loginDetails;

    var state = context.read<LoginBloc>().state;

    // Is this the best way to pop in a bloc refresh?
    if (state.loginResult == LoginResult.success) {
      Navigator.pop(context);
    }

    var username = '';
    var password = '';
    // TODO: Are these in the right place?
    final buildContext = context;

    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        if (loginStatus != null) {
          // If there was an error logging in from the app bloc, then update the error here.
          context.read<LoginBloc>().add(
                LoginError(
                  loginResult: loginStatus,
                  loginDetails: loginDetails ?? '',
                ),
              );
        }
        // if (state.loginResult == LoginResult.success) {
        //   Navigator.pop(context);
        // }

        print('Refreshing');

        return Scaffold(
          appBar: AppBar(
            title: Text('Log in'),
          ),
          body: SafeArea(
            child: Column(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.popAndPushNamed(context, '/register')
                        .then((value) {
                      buildContext
                          .read<EbookSelectionBloc>()
                          .add(const LoadPage());
                      // TODO: Why does this not work? How can I make it update a different bloc?
                    });
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
                                context.read<AppBloc>().add(Login(
                                      username: username,
                                      password: password,
                                    ));
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
