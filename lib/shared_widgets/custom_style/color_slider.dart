import 'package:flutter/material.dart';

class ColorSelection extends StatelessWidget {
  ColorSelection({
    required this.onChange,
    this.color = Colors.white,
  });

  final Function(Color) onChange;
  final Color color;

  @override
  Widget build(BuildContext context) {
    void setRed(int red) {
      onChange(Color.fromARGB(255, red, color.green, color.blue));
    }

    void setGreen(int green) {
      onChange(Color.fromARGB(255, color.red, green, color.blue));
    }

    void setBlue(int blue) {
      onChange(Color.fromARGB(255, color.red, color.green, blue));
    }

    return Column(
      children: <Widget>[
        ColorSlider(
          onChange: setRed,
          value: color.red,
        ),
        ColorSlider(
          onChange: setGreen,
          value: color.green,
        ),
        ColorSlider(
          onChange: setBlue,
          value: color.blue,
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
