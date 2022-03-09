import 'package:flutter/material.dart';
import 'number_entry.dart';
import 'dart:math';

class ColorSelection extends StatelessWidget {
  ColorSelection({
    required this.onChange,
    this.color = Colors.white,
  });

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
      red = colorRangeCheck(red);
      onChange(Color.fromARGB(255, red, color.green, color.blue));
    }

    void setGreen(int green) {
      green = colorRangeCheck(green);
      onChange(Color.fromARGB(255, color.red, green, color.blue));
    }

    void setBlue(int blue) {
      blue = colorRangeCheck(blue);
      onChange(Color.fromARGB(255, color.red, color.green, blue));
    }

    int getWhite() {
      return [color.red, color.green, color.blue].reduce(min);
    }

    void setWhite(int white) {
      white = colorRangeCheck(white);
      var oldWhite = getWhite();
      print('${color.red}, ${color.green}, ${color.blue}, $oldWhite');
      print(white);
      var diff = oldWhite - white;
      print('Diff: $diff');
      onChange(Color.fromARGB(
        255,
        colorRangeCheck(color.red - diff),
        colorRangeCheck(color.green - diff),
        colorRangeCheck(color.blue - diff),
      ));
    }

    return Column(
      children: <Widget>[
        ColorSelector(
          onChange: setRed,
          value: color.red,
        ),
        ColorSelector(
          onChange: setGreen,
          value: color.green,
        ),
        ColorSelector(
          onChange: setBlue,
          value: color.blue,
        ),
        ColorSelector(
          onChange: setWhite,
          value: getWhite(),
        ),
      ],
    );
  }
}

class ColorSlider extends StatelessWidget {
  const ColorSlider({required this.onChange, this.value = 255});

  final Function(int) onChange;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Slider(
      max: 255,
      value: value.toDouble(),
      onChanged: (double newValue) {
        onChange(newValue.toInt());
      },
    );
  }
}

class ColorSelector extends StatelessWidget {
  const ColorSelector({
    required this.onChange,
    required this.value,
    Key? key,
  }) : super(key: key);

  final Function(int) onChange;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: ColorSlider(
            onChange: onChange,
            value: value,
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
