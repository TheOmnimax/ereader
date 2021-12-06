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

  String stringData() {
    return '${backgroundColor.value},${fontColor},${fontSize},${fontFamily},${margins.join(' ')}';
  }

  static EreaderStyle fromStringData(String stringData) {
    var splitData = stringData.split(',');
    var backgroundColor = Color(int.parse(splitData[0]));
    var fontColor = Color(int.parse(splitData[1]));
    var fontSize = int.parse(splitData[2]);
    var fontFamily = splitData[3];
    var margins = splitData[4].split(' ').map(int.parse).toList();
    return EreaderStyle(
        backgroundColor: backgroundColor,
        fontColor: fontColor,
        fontSize: fontSize,
        fontFamily: fontFamily,
        margins: margins);
  }
}
