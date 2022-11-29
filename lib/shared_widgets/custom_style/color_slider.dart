import 'dart:math';
import 'package:ereader/constants/constants.dart';
import 'package:ereader/shared_widgets/custom_style/number_entry.dart';
import 'package:flutter/material.dart';

class ColorSelection extends StatelessWidget {
  const ColorSelection({
    Key? key,
    required this.onChange,
    this.color = Colors.white,
  }) : super(key: key);

  final Function(Color) onChange;
  final Color color;

  @override
  Widget build(BuildContext context) {
    int colorRangeCheck(int num) {
      if (num > 255) {
        return 255;
      } else if (num < 0) {
        return 0;
      } else {
        return num;
      }
    }

    void setRed(int red) {
      onChange(
        Color.fromARGB(
          255,
          colorRangeCheck(red),
          color.green,
          color.blue,
        ),
      );
    }

    void setGreen(int green) {
      onChange(
        Color.fromARGB(
          255,
          color.red,
          colorRangeCheck(green),
          color.blue,
        ),
      );
    }

    void setBlue(int blue) {
      onChange(
        Color.fromARGB(
          255,
          color.red,
          color.green,
          colorRangeCheck(blue),
        ),
      );
    }

    int getWhite() {
      return [color.red, color.green, color.blue].reduce(min);
    }

    void setWhite(int white) {
      final oldWhite = getWhite();
      final diff = oldWhite - colorRangeCheck(white);
      onChange(
        Color.fromARGB(
          255,
          colorRangeCheck(color.red - diff),
          colorRangeCheck(color.green - diff),
          colorRangeCheck(color.blue - diff),
        ),
      );
    }

    return Column(
      children: <Widget>[
        ColorSelector(
          activeColor: Colors.red,
          onChange: setRed,
          thumbColor: Color.fromARGB(255, color.red, 0, 0),
          value: color.red,
        ),
        ColorSelector(
          activeColor: Colors.green,
          onChange: setGreen,
          thumbColor: Color.fromARGB(255, 0, color.green, 0),
          value: color.green,
        ),
        ColorSelector(
          activeColor: Colors.blue,
          onChange: setBlue,
          thumbColor: Color.fromARGB(255, 0, 0, color.blue),
          value: color.blue,
        ),
        ColorSelector(
          activeColor: Colors.white,
          onChange: setWhite,
          thumbColor: Color.fromARGB(255, getWhite(), getWhite(), getWhite()),
          value: getWhite(),
        ),
      ],
    );
  }
}

class ColorSelector extends StatelessWidget {
  const ColorSelector({
    required this.onChange,
    required this.value,
    this.activeColor = themeColor,
    this.thumbColor = themeColor,
    Key? key,
  }) : super(key: key);

  final Function(int) onChange;
  final int value;
  final Color activeColor;
  final Color thumbColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Slider(
            activeColor: activeColor,
            thumbColor: thumbColor,
            max: 255,
            onChanged: (double newValue) {
              onChange(newValue.toInt());
            },
            value: value.toDouble(),
          ),
        ),
        SingleNumberEntry(
          defaultValue: 0,
          onChanged: onChange,
          value: value,
        ),
      ],
    );
  }
}
