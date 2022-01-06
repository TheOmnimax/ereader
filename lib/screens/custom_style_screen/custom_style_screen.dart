import 'package:ereader/constants/constants.dart';
import 'package:ereader/screens/custom_style_screen/bloc/bloc.dart';
import 'package:ereader/shared_data/ereader_style.dart';
import 'package:ereader/shared_widgets/custom_style/custom_style.dart';
import 'package:ereader/shared_widgets/custom_style/style_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../shared_widgets/custom_style/style_modules.dart';
import 'package:ereader/shared_widgets/custom_style/style_preview.dart';

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
      body: BlocBuilder<CustomStyleBloc, CustomStyleState>(
          builder: (context, state) {
        final ereaderStyle = state.ereaderStyle;
        final selectedModule = state.selectedModule;
        // TODO Add var to get currently selected module from bloc

        void updateBackgroundColor(Color color) {
          context.read<CustomStyleBloc>().add(UpdateStyle(
                backgroundColor: color,
              ));
        }

        void updateFontColor(Color color) {
          context.read<CustomStyleBloc>().add(UpdateStyle(
                fontColor: color,
              ));
        }

        void updateFontSize(int size) {}

        void updateFontFamily(String family) {}

        void updateMargins(int top, int right, int bottom, int left) {}

        void updateName(String name) {}

        void moduleTapped(Module module) {
          context
              .read<CustomStyleBloc>()
              .add(ModuleSelected(selectedModule: module));
        }

        return SafeArea(
          child: Column(
            children: [
              StylePreview(
                ereaderStyle: ereaderStyle,
              ),
              StyleSelector(
                onTap: moduleTapped,
                selectedModule: selectedModule,
              ),
              StyleModules(
                ereaderStyle: ereaderStyle,
                visibleModule: selectedModule,
                onBackgroundColorChange: updateBackgroundColor,
                onFontColorChange: updateFontColor,
                onFontSizeChange: updateFontSize,
                onFontFamilyChange: updateFontFamily,
                onMarginsChange: updateMargins,
                onNameChange: updateName,
              ),
              Row(
                children: <Widget>[
                  TextButton(
                    // SAVE
                    onPressed: () async {
                      context.read<CustomStyleBloc>().add(
                            SavePreferences(
                              ereaderStyle: ereaderStyle,
                              context: context,
                            ),
                          );
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}

// // TODO Remove when done
// class ColorSlider extends StatelessWidget {
//   const ColorSlider({required this.workingColor});
//   final Color workingColor;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         Slider(
//           max: 255,
//           value: workingColor.red.toDouble(),
//           onChanged: (double newRed) {
//             context.read<CustomStyleBloc>().add(
//                   ChangeBackgroundColor(
//                     Color.fromARGB(255, newRed.toInt(), workingColor.green,
//                         workingColor.blue),
//                   ),
//                 );
//           },
//         ),
//         Slider(
//           max: 255,
//           value: workingColor.green.toDouble(),
//           onChanged: (double newGreen) {
//             context.read<CustomStyleBloc>().add(
//                   ChangeBackgroundColor(
//                     Color.fromARGB(255, workingColor.red, newGreen.toInt(),
//                         workingColor.blue),
//                   ),
//                 );
//           },
//         ),
//         Slider(
//           max: 255,
//           value: workingColor.blue.toDouble(),
//           onChanged: (double newBlue) {
//             context.read<CustomStyleBloc>().add(
//                   ChangeBackgroundColor(
//                     Color.fromARGB(255, workingColor.red, workingColor.green,
//                         newBlue.toInt()),
//                   ),
//                 );
//           },
//         ),
//       ],
//     );
//   }
// }
