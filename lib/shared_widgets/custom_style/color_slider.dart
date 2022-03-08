import 'package:flutter/material.dart';
import 'number_entry.dart';

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

    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: ColorSlider(
                onChange: setRed,
                value: color.red,
              ),
            ),
            SingleNumberEntry(
              defaultValue: 0,
              onChanged: setRed,
              value: color.red,
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: ColorSlider(
                onChange: setGreen,
                value: color.green,
              ),
            ),
            SingleNumberEntry(
              defaultValue: 0,
              onChanged: setGreen,
              value: color.green,
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: ColorSlider(
                onChange: setBlue,
                value: color.blue,
              ),
            ),
            SingleNumberEntry(
              defaultValue: 0,
              onChanged: setBlue,
              value: color.blue,
            ),
          ],
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
