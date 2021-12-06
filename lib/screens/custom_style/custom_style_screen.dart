import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared_widgets/color_selection.dart';
import 'bloc/custom_style_bloc.dart';
import 'bloc/custom_style_event.dart';
import 'bloc/custom_style_state.dart';
import '../../shared_widgets/main_scaffold.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    var ereaderStyle =
        context.select((CustomStyleBloc bloc) => bloc.state.ereaderStyle);

    void gatherColor() {}

    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom ereader style'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
                color: ereaderStyle.backgroundColor,
                child: Text("The quick brown fox jumped over the lazy dog.")),
            ColorSlider(workingColor: ereaderStyle.backgroundColor),
            Row(
              children: <Widget>[
                TextButton(
                  onPressed: () {},
                  child: const Text('Load'),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Save'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ColorSlider extends StatelessWidget {
  const ColorSlider({required this.workingColor});
  final Color workingColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Slider(
          max: 255,
          value: workingColor.red.toDouble(),
          onChanged: (double newRed) {
            context.read<CustomStyleBloc>().add(
                  ChangeBackgroundColor(
                    Color.fromARGB(255, newRed.toInt(), workingColor.green,
                        workingColor.blue),
                  ),
                );
          },
        ),
        Slider(
          max: 255,
          value: workingColor.green.toDouble(),
          onChanged: (double newGreen) {
            context.read<CustomStyleBloc>().add(
                  ChangeBackgroundColor(
                    Color.fromARGB(255, workingColor.red, newGreen.toInt(),
                        workingColor.blue),
                  ),
                );
          },
        ),
        Slider(
          max: 255,
          value: workingColor.blue.toDouble(),
          onChanged: (double newBlue) {
            context.read<CustomStyleBloc>().add(
                  ChangeBackgroundColor(
                    Color.fromARGB(255, workingColor.red, workingColor.green,
                        newBlue.toInt()),
                  ),
                );
          },
        ),
      ],
    );
  }
}
