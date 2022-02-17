import 'package:ereader/bloc/bloc.dart';
import 'package:ereader/screens/custom_style_screen/custom_style_screen.dart';
import 'package:ereader/screens/ebook_selection_screen/ebook_selection_screen.dart';
//TESTING ONLY!
import 'package:ereader/screens/ereader_screen/ebook_processor/html_processor.dart';
import 'package:ereader/screens/ereader_screen/ereader_screen.dart';
import 'package:ereader/screens/login_screen/login_screen.dart';
import 'package:ereader/screens/registration_screen/registration_screen.dart';
import 'package:ereader/screens/select_style_screen/select_style_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AppBloc()..add(AppOpened()),
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'eReader',
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
        backgroundColor: Color.fromARGB(255, 30, 1, 117),
      )),
      initialRoute: '/',
      routes: {
        '/': (context) => const EbookSelectionMain(),
        '/style_selection': (context) => const SelectStyleMain(),
        '/custom_style': (context) => const CustomStyleMain(),
        '/ereader': (context) => const EreaderMain(),
        '/login': (context) => const LoginMain(),
        '/register': (context) => const RegistrationMain(),
      },
    );
  }
}
