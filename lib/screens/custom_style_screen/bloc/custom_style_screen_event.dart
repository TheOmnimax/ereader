import 'package:ereader/constants/constants.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

abstract class CustomStyleEvent extends Equatable {
  const CustomStyleEvent();

  @override
  List<Object> get props => [];
}

class ChangeBackgroundColor extends CustomStyleEvent {
  ChangeBackgroundColor(this.newColor);

  final Color newColor;

  @override
  List<Object> get props => [newColor];
}

class UpdateStyle extends CustomStyleEvent {
  const UpdateStyle(
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

class ModuleSelected extends CustomStyleEvent {
  ModuleSelected({required this.selectedModule});

  final Module selectedModule;
}

class LoadPreferences extends CustomStyleEvent {
  LoadPreferences(this.preferencesString);

  final String preferencesString;

  @override
  List<Object> get props => [preferencesString];
}
