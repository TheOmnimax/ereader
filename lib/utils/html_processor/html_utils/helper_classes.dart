import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Will divide into a long series of text spans. There will be no nested spans. Will use this to determine where to break it up.
class WordChunk {
  const WordChunk({
    required this.textSpan,
    required this.wordList,
    required this.length,
    this.id = '',
  });

  final TextSpan textSpan;
  final List<String> wordList;
  final int length;
  final String id;

  static WordChunk buildWordChunk({
    required TextSpan textSpan,
    String id = '',
  }) {
    final List<String> wordList = (textSpan.text ?? '').split(' ');
    final length = (textSpan.text ?? '').length;

    return WordChunk(
      textSpan: textSpan,
      wordList: wordList,
      length: length,
      id: id,
    );
  }
}

// Will add more later, but these are the only ones I need.
extension CopyWith on TextSpan {
  TextSpan copyWith({
    List<InlineSpan>? children,
    TextStyle? style,
    String? text,
  }) {
    return TextSpan(
      children: children ?? this.children,
      style: style ?? this.style,
      text: text ?? this.text,
    );
  }
}
