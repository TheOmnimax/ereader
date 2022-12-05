import 'package:equatable/equatable.dart';
import 'package:ereader/shared_data/ereader_style.dart';

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
    EreaderStyle selectedEreaderStyle = const EreaderStyle(),
    List<EreaderStyle> allStyles = const <EreaderStyle>[],
  }) : super(
          selectedEreaderStyle: selectedEreaderStyle,
          allStyles: allStyles,
        );

  @override
  List<Object?> get props => [selectedEreaderStyle, allStyles];

  @override
  SelectStyleMainState copyWith({
    List<EreaderStyle>? allStyles,
    EreaderStyle? selectedEreaderStyle,
  }) {
    return SelectStyleMainState(
      allStyles: allStyles ?? [],
      selectedEreaderStyle: selectedEreaderStyle ?? this.selectedEreaderStyle,
    );
  }
}
