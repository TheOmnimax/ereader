import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared_widgets/color_selection.dart';
import 'bloc/custom_style_bloc.dart';
import 'bloc/custom_style_event.dart';
import 'bloc/custom_style_state.dart';

class CustomStyleMain extends StatelessWidget {
  const CustomStyleMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CustomStyleBloc(),
      child: const CustomStyleScreen(),
    );
  }
}

class CustomStyleScreen extends StatelessWidget {
  const CustomStyleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom ereader style'),
      ),
      body: SafeArea(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
