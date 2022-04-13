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

class TextSpanTextDivision {
  TextSpanTextDivision({
    required this.currentText,
    this.nextText = null,
  });

  final String currentText;
  final String? nextText;
}

class TextSpanDivider {
  TextSpanDivider({
    required this.workingSpan,
    required this.pageEndIndex,
  });

  final TextSpan workingSpan;
  final int pageEndIndex;
  var atIndex = 0;
  var over = false;
  var atTop = false;

  TextSpanTextDivision _processText({
    required String spanText,
  }) {
    if (spanText.length + atIndex < pageEndIndex) {
      atIndex += spanText.length;
      return TextSpanTextDivision(currentText: spanText);
    } else {
      final textWords = spanText.split(RegExp(r' +'));

      final currentWords = <String>[];
      final nextWords = <String>[];
      for (final word in textWords) {
        if (!over &&
            ((currentWords + [word]).join(' ').length + atIndex <
                pageEndIndex)) {
          // Check if the new word will cause it to overtake
          currentWords.add(word);
        } else {
          over = true;
          atTop = true;
          nextWords.add(word);
        }
      } // End FOR through each word in text property
      final currentText = currentWords.join(' ');
      atIndex += currentText.length;
      if (nextWords.length > 0) {
        return TextSpanTextDivision(
          currentText: currentText,
          nextText: nextWords.join(' '),
        );
      } else {
        return TextSpanTextDivision(
          currentText: currentText,
        );
      }
    }
  }

  TextSpanChildrenDivision _processChildren({
    required List<TextSpan> textSpanChildren,
  }) {
    final currentChildren = <TextSpan>[];
    final nextChildren = <TextSpan>[];
    for (final child in textSpanChildren) {
      if (over) {
        nextChildren.add(child);
      } else {
        final workingText;
        var nextText;

        final spanText = child.text;
        if (spanText != null) {
          if (over) {
            // Already over, so can stop checking
            workingText = null;
            nextText = spanText;
            currentChildren.add(TextSpan(
              text: spanText,
              style: child.style,
            ));
          } else {
            final splitText = _processText(spanText: spanText);
            workingText = splitText.currentText;
            nextText = splitText.nextText;
            /*if (over) {
              currentChildren.add(TextSpan(
                text: workingText,
                style: child.style,
              ));
            }*/
          }
        } // End IF span text exists
        else {
          workingText = null;
          nextText = null;
        }

        final spanChildrenRaw = child.children;
        final spanChildren;
        if (spanChildrenRaw == null) {
          spanChildren = <TextSpan>[];
        } else {
          spanChildren = spanChildrenRaw as List<TextSpan>;
        }
        // final spanChildren = child.children ?? <TextSpan>[];

        if (over && atTop && (nextText == '\n')) {
          nextText = null;
          atTop = false;
        }

        if (spanChildren.length > 0) {
          if (over) {
            nextChildren.add(TextSpan(
              text: nextText,
              children: child.children,
              style: child.style,
            ));
          } else {
            final childDivision =
                _processChildren(textSpanChildren: spanChildren);
            currentChildren.add(TextSpan(
              text: workingText,
              children: childDivision.currentChildren,
              style: child.style,
            ));
            if (childDivision.nextChildren.length > 0) {
              nextChildren.add(TextSpan(
                children: childDivision.nextChildren,
                style: child.style,
              ));
            }
          }
        } else if (workingText != null) {
          currentChildren.add(TextSpan(
            text: workingText,
            style: child.style,
          ));
          nextChildren.add(TextSpan(
            text: nextText,
            style: child.style,
          ));
        }
      } // End not over
    } // End FOR through each child originally given
    return TextSpanChildrenDivision(
      currentChildren: currentChildren,
      nextChildren: nextChildren,
    );
  }

  TextSpanDivision getDivision() {
    atTop = true;

    final currentText;
    final nextText;
    final currentChildren;
    final nextChildren;

    final spanText = workingSpan.text;
    if (spanText != null) {
      final splitText = _processText(spanText: spanText);
      currentText = splitText.currentText;
      nextText = splitText.nextText;
    } else {
      currentText = null;
      nextText = null;
    }
    final spanChildrenRaw = workingSpan.children;
    final spanChildren;
    if (spanChildrenRaw == null) {
      spanChildren = <TextSpan>[];
    } else {
      spanChildren = spanChildrenRaw as List<TextSpan>;
    }
    if (spanChildren.length > 0) {
      final splitChildren = _processChildren(textSpanChildren: spanChildren);
      currentChildren = splitChildren.currentChildren;
      nextChildren = splitChildren.nextChildren;
    } else {
      currentChildren = null;
      nextChildren = null;
    }

    final currentSpan;
    if ((currentText == null) && (currentChildren.length == 0)) {
      currentSpan = null; // Don't bother adding it if there is nothing to add
    } else {
      currentSpan = TextSpan(
        text: currentText,
        children: currentChildren,
        style: workingSpan.style,
      );
    }

    final nextSpan;
    if (nextText == null && (nextChildren.length == 0)) {
      nextSpan = null; // Don't bother adding it if there is nothing to add
    } else {
      nextSpan = TextSpan(
        text: nextText,
        children: nextChildren,
        style: workingSpan.style,
      );
    }

    return TextSpanDivision(
      currentSpan: currentSpan,
      nextSpan: nextSpan,
    );
  }
}

class TextSpanChildrenDivision {
  TextSpanChildrenDivision({
    required this.currentChildren,
    required this.nextChildren,
  });

  final List<TextSpan> currentChildren;
  final List<TextSpan> nextChildren;
}

class TextSpanDivision {
  TextSpanDivision({
    required this.currentSpan,
    this.nextSpan,
  });

  final TextSpan currentSpan;
  final TextSpan? nextSpan;
  var atText = 0;
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
