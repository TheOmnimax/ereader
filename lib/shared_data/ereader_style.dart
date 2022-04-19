import 'package:flutter/material.dart';
import 'dart:convert';

class EreaderStyle {
  const EreaderStyle({
    this.backgroundColor = Colors.white,
    this.fontColor = Colors.black,
    this.fontSize = 12,
    this.fontFamily = 'Arial',
    this.margins = const [8, 8, 8, 8],
    this.name = 'Custom style',
  });

  EreaderStyle.fromJson(Map<String, dynamic> json)
      : backgroundColor = Color(json['backgroundColor'] as int),
        fontColor = Color(json['fontColor'] as int),
        fontSize = json['fontSize'] as int,
        fontFamily = json['fontFamily'] as String,
        margins = List<int>.from(json['margins'] as List<dynamic>),
        name = json['name'] as String;

  final Color backgroundColor;
  final Color fontColor;
  final int fontSize;
  final String fontFamily;
  final List<int> margins;
  final String name;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'backgroundColor': backgroundColor.value,
        'fontColor': fontColor.value,
        'fontSize': fontSize,
        'fontFamily': fontFamily,
        'margins': margins,
        'name': name,
      };

  // String toString() {
  //
  // }

  String stringData() {
    // Deprecated
    return '${backgroundColor.value},${fontColor.value},${fontSize},${fontFamily},${margins.join(' ')}';
  }

  static EreaderStyle fromStringData(String stringData) {
    // Deprecated
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

  TextStyle toTextStyle() {
    return TextStyle(
      fontSize: fontSize.toDouble(),
      color: fontColor,
    );
  }
}
