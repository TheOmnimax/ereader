import '../../../shared_data/ereader_style.dart';
import 'package:equatable/equatable.dart';

abstract class CustomStyleState extends Equatable {
  const CustomStyleState({required this.ereaderStyle});

  final EreaderStyle ereaderStyle;

  @override
  List<Object> get props => [ereaderStyle];
}

class StyleInitial extends CustomStyleState {
  StyleInitial() : super(ereaderStyle: const EreaderStyle());
}

class StyleAdjusted extends CustomStyleState {
  const StyleAdjusted({required EreaderStyle ereaderStyle})
      : super(ereaderStyle: ereaderStyle);
  // Why do I have to define the type in the initializer?
}
