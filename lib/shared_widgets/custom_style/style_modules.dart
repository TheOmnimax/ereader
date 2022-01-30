import 'package:ereader/constants/constants.dart';
import 'package:ereader/shared_data/ereader_style.dart';
import 'package:ereader/shared_widgets/custom_style/color_slider.dart';
import 'package:ereader/shared_widgets/custom_style/number_entry.dart';

import 'package:ereader/shared_widgets/buttons.dart';
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
            print('Top change');
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

          return MarginEntry(
            onChangedFunctions: [
              onTopChange,
              onRightChange,
              onBottomChange,
              onLeftChange,
            ],
            margins: ereaderStyle.margins,
          );
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

class MarginEntry extends StatefulWidget {
  const MarginEntry({
    required this.margins,
    required this.onChangedFunctions,
    Key? key,
  }) : super(key: key);

  final List<int> margins;
  final List<Function(int)> onChangedFunctions;

  @override
  _MarginEntryState createState() => _MarginEntryState();
}

class _MarginEntryState extends State<MarginEntry> {
  Position position = Position.top;
  @override
  Widget build(BuildContext context) {
    var selectedMarginValue = widget.margins[0];
    var onChanged = widget.onChangedFunctions[0];

    void updateSelectedPos(Position newPos) {
      setState(() {
        position = newPos;
        print('Selected: $position');
        switch (position) {
          case Position.top:
            {
              // position = widget.margins as Position;
              selectedMarginValue = widget.margins[0];
              onChanged = widget.onChangedFunctions[0];
            }
            break;
          case Position.right:
            {
              selectedMarginValue = widget.margins[1];
              onChanged = widget.onChangedFunctions[1];
              break;
            }
          case Position.bottom:
            {
              selectedMarginValue = widget.margins[2];
              onChanged = widget.onChangedFunctions[2];
              break;
            }
          case Position.left:
            {
              selectedMarginValue = widget.margins[3];
              onChanged = widget.onChangedFunctions[3];
              break;
            }
          default:
            {
              selectedMarginValue = 0;
            }
        }
      });
    }

    updateSelectedPos(position);

    print('New position: $position');

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Row(
          children: [
            Row(
              children: [
                Column(
                  children: <Widget>[
                    CircleButton(
                      icon: Icons.arrow_back,
                      onChanged: () {
                        updateSelectedPos(Position.left);
                      },
                      selected: position == Position.left,
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    CircleButton(
                      icon: Icons.arrow_upward,
                      onChanged: () {
                        updateSelectedPos(Position.top);
                      },
                      selected: position == Position.top,
                    ),
                    CircleButton(
                      icon: Icons.arrow_downward,
                      onChanged: () {
                        updateSelectedPos(Position.bottom);
                      },
                      selected: position == Position.bottom,
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    CircleButton(
                      icon: Icons.arrow_forward,
                      onChanged: () {
                        updateSelectedPos(Position.right);
                      },
                      selected: position == Position.right,
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
        SingleNumberEntry(
          value: selectedMarginValue,
          unit: 'dp',
          onChanged: onChanged,
        ),
      ],
    );
  }
}
