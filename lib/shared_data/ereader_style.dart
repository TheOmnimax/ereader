import 'package:flutter/material.dart';

class EreaderStyle {
  const EreaderStyle(
      {this.backgroundColor = Colors.white,
      this.fontColor = Colors.black,
      this.fontSize = 12,
      this.fontFamily = 'Arial',
      this.margins = const [8, 8, 8, 8]});

  final Color backgroundColor;
  final Color fontColor;
  final int fontSize;
  final String fontFamily;
  final List<int> margins;
}
