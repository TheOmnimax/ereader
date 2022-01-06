import 'package:equatable/equatable.dart';
import 'package:ereader/shared_data/ereader_style.dart';
import 'package:flutter/material.dart';

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
