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

class LoadPreferences extends CustomStyleEvent {
  LoadPreferences(this.preferencesString);

  final String preferencesString;

  @override
  List<Object> get props => [preferencesString];
}
