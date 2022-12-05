import 'package:flutter/material.dart';

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

  TextStyle toTextStyle() {
    return TextStyle(
      fontSize: fontSize.toDouble(),
      color: fontColor,
    );
  }
}
