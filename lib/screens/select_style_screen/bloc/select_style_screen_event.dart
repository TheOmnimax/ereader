import 'package:equatable/equatable.dart';
import 'package:ereader/shared_data/ereader_style.dart';

abstract class SelectStyleEvent extends Equatable {
  const SelectStyleEvent();

  @override
  List<Object> get props => [];
}

class LoadPage extends SelectStyleEvent {
  const LoadPage();
}

class PageLoaded extends SelectStyleEvent {
  const PageLoaded({
    this.ereaderStyle = const EreaderStyle(),
  });

  final EreaderStyle ereaderStyle;
}

class StyleSelected extends SelectStyleEvent {
  const StyleSelected({
    required this.ereaderStyle,
  });

  final EreaderStyle ereaderStyle;
}

class StyleMove extends SelectStyleEvent {
  const StyleMove({
    required this.ereaderStyle,
    required this.move,
  });

  final EreaderStyle ereaderStyle;
  final int move;
}

class StyleEdit extends SelectStyleEvent {
  const StyleEdit({
    required this.ereaderStyle,
  });

  final EreaderStyle ereaderStyle;
}

class StyleDelete extends SelectStyleEvent {
  const StyleDelete({
    required this.ereaderStyle,
  });

  final EreaderStyle ereaderStyle;
}
