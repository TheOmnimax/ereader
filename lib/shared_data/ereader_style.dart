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
    return '${backgroundColor.value},${fontColor.value},${fontSize},${fontFamily},${margins.join(' ')}';
  }

  static EreaderStyle fromStringData(String stringData) {
    print('Parsing new data');
    var splitData = stringData.split(',');
    var backgroundColor = Color(int.parse(splitData[0]));
    print('Got background');
    var fontColor = Color(int.parse(splitData[1]));
    print('Got font color');
    var fontSize = int.parse(splitData[2]);
    var fontFamily = splitData[3];
    var margins = splitData[4].split(' ').map(int.parse).toList();
    print('Retrieved data');
    return EreaderStyle(
        backgroundColor: backgroundColor,
        fontColor: fontColor,
        fontSize: fontSize,
        fontFamily: fontFamily,
        margins: margins);
  }
}
