import 'package:ereader/constants/constants.dart';
import 'package:ereader/shared_data/ereader_style.dart';
import 'package:ereader/shared_widgets/custom_style/color_slider.dart';
import 'package:ereader/shared_widgets/custom_style/number_entry.dart';
import 'package:flutter/material.dart';

class StyleModules extends StatelessWidget {
  const StyleModules({
    required this.ereaderStyle,
    required this.visibleModule,
    required this.onFontColorChange,
    required this.onBackgroundColorChange,
    required this.onFontSizeChange,
    required this.onFontFamilyChange,
    required this.onMarginsChange,
    required this.onNameChange,
  });

  final EreaderStyle ereaderStyle;
  final Module visibleModule;
  final Function(Color) onBackgroundColorChange;
  final Function(Color) onFontColorChange;
  final Function(int) onFontSizeChange;
  final Function(String) onFontFamilyChange;
  final Function(int, int, int, int) onMarginsChange;
  final Function(String) onNameChange;

  @override
  Widget build(BuildContext context) {
    switch (visibleModule) {
      case Module.backgroundColor:
        {
          return ColorSelection(
            onChange: onBackgroundColorChange,
            color: ereaderStyle.backgroundColor,
          );
        }
      case Module.fontColor:
        {
          return ColorSelection(
            onChange: onFontColorChange,
            color: ereaderStyle.fontColor,
          );
        }
      case Module.fontSize:
        {
          return SingleNumberEntry(
            onChanged: onFontSizeChange,
            value: ereaderStyle.fontSize,
            unit: 'dp',
          );
        }
      case Module.fontFamily:
        {
          return Container();
        }
      case Module.margins:
        {
          return Container();
        }
      case Module.name:
        {
          return Container(
            child: TextField(
              onChanged: onNameChange,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          );
        }
      default:
        {
          return Container();
        }
    }
  }
}
