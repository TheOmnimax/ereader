import 'package:equatable/equatable.dart';
import 'package:ereader/constants/constants.dart';
import 'package:ereader/shared_data/ereader_style.dart';
import 'package:flutter/material.dart';

abstract class CustomStyleEvent extends Equatable {
  const CustomStyleEvent();

  @override
  List<Object> get props => [];
}

class UpdateStyle extends CustomStyleEvent {
  const UpdateStyle({
    this.backgroundColor,
    this.fontColor,
    this.fontSize,
    this.fontFamily,
    this.margins,
    this.name,
  });

  final Color? backgroundColor;
  final Color? fontColor;
  final int? fontSize;
  final String? fontFamily;
  final List<int>? margins;
  final String? name;
}

class ModuleSelected extends CustomStyleEvent {
  const ModuleSelected({required this.selectedModule});

  final Module selectedModule;
}

class SavePreferences extends CustomStyleEvent {
  const SavePreferences({
    required this.ereaderStyle,
    required this.context,
  });

  final EreaderStyle ereaderStyle;
  final BuildContext context;
}

// class SavePreferences extends CustomStyleEvent {
//   const SavePreferences({
//     required this.backgroundColor,
//     required this.fontColor,
//     required this.fontSize,
//     required this.fontFamily,
//     required this.margins,
//     required this.name,
//   });
//
//   final Color backgroundColor;
//   final Color fontColor;
//   final int fontSize;
//   final String fontFamily;
//   final List<int> margins;
//   final String name;
// }

class LoadPreferences extends CustomStyleEvent {
  const LoadPreferences(this.preferencesString);

  final String preferencesString;

  @override
  List<Object> get props => [preferencesString];
}
