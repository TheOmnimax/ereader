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
  final List<EreaderStyle> allStyles;

  @override
  List<Object?> get props => [];

  SelectStyleScreenState copyWith({
    List<EreaderStyle>? allStyles,
    EreaderStyle? selectedEreaderStyle,
    // String? selectedStyle,
  });
}

class SelectStyleLoading extends SelectStyleScreenState {
  const SelectStyleLoading();

  @override
  SelectStyleLoading copyWith({
    List<EreaderStyle>? allStyles,
    EreaderStyle? selectedEreaderStyle,
    // String? selectedStyle,
  }) {
    return const SelectStyleLoading();
  }
}

class SelectStyleMainState extends SelectStyleScreenState {
  const SelectStyleMainState({
    this.selectedEreaderStyle = const EreaderStyle(),
    this.allStyles = const <EreaderStyle>[],
    // this.selectedStyle = '',
  });

  final EreaderStyle selectedEreaderStyle;
  final List<EreaderStyle> allStyles;

  @override
  List<Object?> get props => [selectedEreaderStyle, allStyles];

  @override
  SelectStyleMainState copyWith({
    List<EreaderStyle>? allStyles,
    EreaderStyle? selectedEreaderStyle,
    // String? selectedStyle,
  }) {
    return SelectStyleMainState(
      allStyles: allStyles ?? [],
      selectedEreaderStyle: selectedEreaderStyle ?? this.selectedEreaderStyle,
      // selectedStyle: selectedStyle ?? this.selectedStyle,
    );
  }
}
