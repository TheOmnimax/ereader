import 'package:equatable/equatable.dart';
import 'package:ereader/shared_data/ereader_style.dart';

abstract class CustomStyleState extends Equatable {
  const CustomStyleState({required this.ereaderStyle});

  final EreaderStyle ereaderStyle;

  @override
  List<Object> get props => [ereaderStyle];
}

class StyleInitial extends CustomStyleState {
  const StyleInitial() : super(ereaderStyle: const EreaderStyle());
}

class StyleAdjusted extends CustomStyleState {
  const StyleAdjusted({required EreaderStyle ereaderStyle})
      : super(ereaderStyle: ereaderStyle);
}

// class ModuleChanged extends CustomStyleState {
//
// }
