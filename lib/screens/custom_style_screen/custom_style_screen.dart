import 'package:ereader/constants/constants.dart';
import 'package:ereader/screens/custom_style_screen/bloc/bloc.dart';
import 'package:ereader/shared_data/ereader_style.dart';
import 'package:ereader/shared_widgets/custom_style/custom_style.dart';
import 'package:ereader/shared_widgets/custom_style/style_modules.dart';
import 'package:ereader/shared_widgets/custom_style/style_preview.dart';
import 'package:ereader/shared_widgets/custom_style/style_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomStyleMain extends StatelessWidget {
  const CustomStyleMain({
    Key? key,
    this.defaultStyle = const EreaderStyle(),
  }) : super(key: key);

  final EreaderStyle defaultStyle;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CustomStyleBloc(),
      child: CustomStyleScreen(
        defaultStyle: defaultStyle,
      ),
    );
  }
}

class CustomStyleScreen extends StatelessWidget {
  const CustomStyleScreen({
    Key? key,
    this.defaultStyle = const EreaderStyle(),
  }) : super(key: key);

  final EreaderStyle defaultStyle;

  @override
  Widget build(BuildContext context) {
    context.read<CustomStyleBloc>().add(
          UpdateStyle(
            backgroundColor: defaultStyle.backgroundColor,
            fontColor: defaultStyle.fontColor,
            fontSize: defaultStyle.fontSize,
            fontFamily: defaultStyle.fontFamily,
            margins: defaultStyle.margins,
            name: defaultStyle.name,
          ),
        );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom ereader style'),
      ),
      body: BlocBuilder<CustomStyleBloc, CustomStyleState>(
        builder: (context, state) {
          final ereaderStyle = state.ereaderStyle;
          final selectedModule = state.selectedModule;

          void updateBackgroundColor(Color color) {
            context.read<CustomStyleBloc>().add(
                  UpdateStyle(
                    backgroundColor: color,
                  ),
                );
          }

          void updateFontColor(Color color) {
            context.read<CustomStyleBloc>().add(
                  UpdateStyle(
                    fontColor: color,
                  ),
                );
          }

          void updateFontSize(int size) {
            context.read<CustomStyleBloc>().add(
                  UpdateStyle(
                    fontSize: size,
                  ),
                );
          }

          void updateFontFamily(String family) {
            context.read<CustomStyleBloc>().add(
                  UpdateStyle(
                    fontFamily: family,
                  ),
                );
          }

          void updateMargins(int top, int right, int bottom, int left) {
            context.read<CustomStyleBloc>().add(
                  UpdateStyle(
                    margins: [top, right, bottom, left],
                  ),
                );
          }

          void updateName(String name) {
            context.read<CustomStyleBloc>().add(
                  UpdateStyle(
                    name: name,
                  ),
                );
          }

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
        },
      ),
    );
  }
}
