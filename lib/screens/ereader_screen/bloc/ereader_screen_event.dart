import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class EreaderEvent extends Equatable {
  const EreaderEvent();

  @override
  List<Object> get props => [];
}

class LoadBook extends EreaderEvent {
  const LoadBook({
    required this.workingHeight,
    required this.workingWidth,
    required this.style,
  });

  final double workingHeight;
  final double workingWidth;
  final TextStyle style;
}

class WordSelected extends EreaderEvent {
  const WordSelected({
    required this.selectedWord,
  });
  final String selectedWord;
}
