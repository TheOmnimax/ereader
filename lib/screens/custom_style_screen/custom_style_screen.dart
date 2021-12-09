import 'package:ereader/constants/constants.dart';
import 'package:ereader/screens/custom_style_screen/bloc/custom_style_screen_bloc.dart';
import 'package:ereader/screens/custom_style_screen/bloc/custom_style_screen_event.dart';
import 'package:ereader/shared_data/ereader_style.dart';
import 'package:ereader/shared_widgets/custom_style/custom_style.dart';
import 'package:ereader/shared_widgets/custom_style/style_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'style_modules.dart';

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
    final ereaderStyle =
        context.select((CustomStyleBloc bloc) => bloc.state.ereaderStyle);
    // TODO Add var to get currently selected module from bloc

    void updateStyle({
      Color backgroundColor = Colors.white,
      Color fontColor = Colors.black,
      int fontSize = 12,
      String fontFamily = 'Arial',
      List<int> margins = const [8, 8, 8, 8],
    }) {
      context.read<CustomStyleBloc>().add(
            UpdateStyle(
              backgroundColor: backgroundColor,
              fontColor: fontColor,
              fontSize: fontSize,
              fontFamily: fontFamily,
              margins: margins,
            ),
          );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom ereader style'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: ereaderStyle.backgroundColor,
              child: Text(kSampleText),
              // width: double.infinity,
            ),
            const StyleSelector(),
            StyleModules(
              visibleModule: Module.backgroundColor,
            ),
            Row(
              children: <Widget>[
                TextButton(
                  // LOAD
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    final preferences = prefs.getString('preferences');
                    print(preferences);
                    context.read<CustomStyleBloc>().add(LoadPreferences(
                        preferences ?? EreaderStyle().stringData()));
                  },
                  child: const Text('Load'),
                ),
                TextButton(
                  // SAVE
                  onPressed: () async {
                    var preferenceString = ereaderStyle.stringData();
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setString('preferences',
                        preferenceString); // Why is the "await" keyword needed"? It is not in the cookbook. https://docs.flutter.dev/cookbook/persistence/key-value
                  },
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
