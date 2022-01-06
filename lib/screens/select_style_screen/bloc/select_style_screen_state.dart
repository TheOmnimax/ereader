import 'package:ereader/constants/constants.dart';
import 'package:equatable/equatable.dart';
import 'package:ereader/shared_data/ereader_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:ereader/shared_data/shared_preferences.dart';

abstract class SelectStyleScreenState extends Equatable {
  const SelectStyleScreenState({
    this.selectedEreaderStyle = const EreaderStyle(),
    this.allStyles = const <EreaderStyle>[],
  });

  final EreaderStyle selectedEreaderStyle;
  // TODO: Find how to not use ereaderStyle in parent state, since not needed for all child states
  // get currentState => String 'Other';
  // TODO: Find how to set thsi up properly
  final List<EreaderStyle> allStyles;

  @override
  List<Object?> get props => [];

  SelectStyleScreenState copyWith({
    List<EreaderStyle>? allStyles,
    EreaderStyle? ereaderStyle,
    // String? selectedStyle,
  });
}

class SelectStyleLoading extends SelectStyleScreenState {
  const SelectStyleLoading();

  @override
  SelectStyleLoading copyWith({
    List<EreaderStyle>? allStyles,
    EreaderStyle? ereaderStyle,
    // String? selectedStyle,
  }) {
    return const SelectStyleLoading();
  }
}

class SelectStyleMainState extends SelectStyleScreenState {
  SelectStyleMainState({
    this.selectedEreaderStyle = const EreaderStyle(),
    this.allStyles = const <EreaderStyle>[],
    // this.selectedStyle = '',
  });

  final EreaderStyle selectedEreaderStyle;
  // final String selectedStyle;
  final List<EreaderStyle> allStyles;

  @override
  List<Object?> get props => [selectedEreaderStyle];

  SelectStyleMainState copyWith({
    List<EreaderStyle>? allStyles,
    EreaderStyle? ereaderStyle,
    // String? selectedStyle,
  }) {
    return SelectStyleMainState(
      allStyles: allStyles ?? [],
      selectedEreaderStyle: ereaderStyle ?? this.selectedEreaderStyle,
      // selectedStyle: selectedStyle ?? this.selectedStyle,
    );
  }
}
