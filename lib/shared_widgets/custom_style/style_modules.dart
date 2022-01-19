import 'package:ereader/constants/constants.dart';
import 'package:ereader/shared_data/ereader_style.dart';
import 'package:ereader/shared_widgets/custom_style/color_slider.dart';
import 'package:ereader/shared_widgets/custom_style/number_entry.dart';
import 'package:flutter/material.dart';

class StyleModules extends StatelessWidget {
  const StyleModules({
    Key? key,
    required this.ereaderStyle,
    required this.visibleModule,
    required this.onFontColorChange,
    required this.onBackgroundColorChange,
    required this.onFontSizeChange,
    required this.onFontFamilyChange,
    required this.onMarginsChange,
    required this.onNameChange,
  }) : super(key: key);

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
          print('Margins: ${ereaderStyle.margins}');
          void onTopChange(int value) {
            onMarginsChange(
              value,
              ereaderStyle.margins[1],
              ereaderStyle.margins[2],
              ereaderStyle.margins[3],
            );
          }

          void onRightChange(int value) {
            onMarginsChange(
              ereaderStyle.margins[0],
              value,
              ereaderStyle.margins[2],
              ereaderStyle.margins[3],
            );
          }

          void onBottomChange(int value) {
            onMarginsChange(
              ereaderStyle.margins[0],
              ereaderStyle.margins[1],
              value,
              ereaderStyle.margins[3],
            );
          }

          void onLeftChange(int value) {
            onMarginsChange(
              ereaderStyle.margins[0],
              ereaderStyle.margins[1],
              ereaderStyle.margins[2],
              value,
            );
          }

          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  SingleNumberEntry(
                    value: ereaderStyle.margins[3],
                    unit: 'dp',
                    onChanged: onLeftChange,
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  SingleNumberEntry(
                    value: ereaderStyle.margins[0],
                    unit: 'dp',
                    onChanged: onTopChange,
                  ),
                  SingleNumberEntry(
                    value: ereaderStyle.margins[2],
                    unit: 'dp',
                    onChanged: onBottomChange,
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  SingleNumberEntry(
                    value: ereaderStyle.margins[1],
                    unit: 'dp',
                    onChanged: onRightChange,
                  ),
                ],
              ),
            ],
          );

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
