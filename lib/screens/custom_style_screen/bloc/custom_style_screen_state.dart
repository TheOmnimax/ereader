import 'package:equatable/equatable.dart';
import 'package:ereader/constants/constants.dart';
import 'package:ereader/shared_data/ereader_style.dart';

class CustomStyleState extends Equatable {
  const CustomStyleState({
    this.ereaderStyle = const EreaderStyle(),
    this.selectedModule = Module.backgroundColor,
  });

  final EreaderStyle ereaderStyle;
  final Module selectedModule;

  @override
  List<Object?> get props => [ereaderStyle, selectedModule];

  CustomStyleState copyWith({
    EreaderStyle? ereaderStyle,
    Module? selectedModule,
  }) {
    return CustomStyleState(
      ereaderStyle: ereaderStyle ?? this.ereaderStyle,
      selectedModule: selectedModule ?? this.selectedModule,
    );
  }
}
