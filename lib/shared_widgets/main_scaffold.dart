import 'package:flutter/material.dart';

class MainScaffold extends StatelessWidget {
  const MainScaffold({
    required this.child,
    required this.popupMenuButton,
    Key? key,
  }) : super(key: key);

  final Widget child;
  final PopupMenuButton popupMenuButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        title: const Text('eReader'),
        actions: <Widget>[
          popupMenuButton,
        ],
        backgroundColor: const Color.fromARGB(255, 30, 1, 117),
      ),
      body: SafeArea(
        child: child,
      ),
    );
  }
}
