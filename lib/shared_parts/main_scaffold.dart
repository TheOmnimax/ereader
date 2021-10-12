import 'package:flutter/material.dart';

class MainScaffold extends StatefulWidget {
  final Widget child;
  final Function kebab;

  const MainScaffold({Key? key, required this.child, required this.kebab})
      : super(key: key);

  @override
  _MainScaffoldState createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        title: const Text('eReader'),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
            ),
          ),
        ],
        backgroundColor: const Color.fromARGB(255, 30, 1, 117),
      ),
      body: SafeArea(
        child: widget.child,
      ),
    );
  }
}
