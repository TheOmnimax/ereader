import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'element_processor.dart';
import 'helper_classes.dart';
import 'used_classes.dart';

class HtmlDisplayTool {
  HtmlDisplayTool._({
    required this.textSpanList,
    required this.wordChunks,
    required this.plainText,
  });

  final List<TextSpan> textSpanList;
  final List<WordChunk> wordChunks;
  final String plainText;

  static HtmlDisplayTool fromHtml(String htmlContent) {
    // Start by clearing readability elements
    htmlContent = htmlContent.replaceAll(RegExp('[\n\r\t]'), '');
    htmlContent = htmlContent.replaceAll(RegExp(r' {2,}'), ' ');

    final document = parse(htmlContent);

    final body = document.body;

    if (body != null) {
      final elementProcessor = ElementProcessor(topElement: body)
        ..runProcessor();

      return HtmlDisplayTool._(
        textSpanList: elementProcessor.textSpanList,
        wordChunks: elementProcessor.wordChunks,
        plainText: elementProcessor.plainText,
      );
    } else {
      return HtmlDisplayTool._(
        textSpanList: [],
        wordChunks: [],
        plainText: '',
      );
    }
  }

  // Creates a text painter that is used to determine which text is on which lines, which is used to determine when to break up the pages
  TextPainter _generatePainter({
    required List<TextSpan> textSpanList,
    required double maxWidth,
    TextStyle style = const TextStyle(),
  }) {
    final textPainter = TextPainter(
      text: TextSpan(
        children: textSpanList,
        style: style,
      ),
      textDirection: TextDirection.ltr,
    )..layout(
        maxWidth: maxWidth - 3,
      );
    return textPainter;
  }

  List<PageData> pageBreaker({
    required double pageHeight,
    required double pageWidth,
    TextStyle defaultStyle = const TextStyle(),
  }) {
    pageWidth -=
        3; // Subtract 3, or it may not calculate properly. I'm not sure why! 2 is too little, so it may take some trial-and-error to adjust this.
    // print('Starting page breaker.');
    // print(pageHeight);
    // print(pageWidth);
    final remainingChunks = List<WordChunk>.from(
        wordChunks); // All word chunks. Occasionally added to when there is leftover text from the last page
    final remainingSpans = List<TextSpan>.from(
        textSpanList); // Used to create the text painter each time to determine when the page overflows, and at the end to create the last page. Unlike the remaining chunks, when a remainingSpans element is used on the page, it is removed from this list.

    final pages = <PageData>[];

    var onChunk = 0;
    var numChunks = remainingChunks.length;
    final currentPage = <TextSpan>[];

    chunkLoop:
    while (onChunk < numChunks) {
      // Remove leading line breaks on new pages
      if (remainingSpans[0].text == '\n') {
        remainingSpans.removeAt(0);
        onChunk++;
        if (onChunk >= numChunks) {
          break;
        }
      }

      final textPainter = _generatePainter(
          textSpanList: remainingSpans,
          maxWidth: pageWidth,
          style: defaultStyle);
      final lineMetrics = textPainter.computeLineMetrics();

      // print('There are ${lineMetrics.length} lines');
      for (var i = 0; i < lineMetrics.length; i++) {
        final line = lineMetrics[i]; // Line metrics of the current line

        final left = line.left;
        final top = line.baseline - line.ascent;
        final bottom = line.baseline + line.descent;

        if (pageHeight < bottom) {
          // True if the content is too long for the page. If false, it means the content can fit, and it can simply be added without breaking up the page
          // print('Overtaking');
          final currentPageEndIndex =
              textPainter.getPositionForOffset(Offset(left, top)).offset;

          var currentLength = 0;
          while (
              (onChunk < numChunks) && (currentLength < currentPageEndIndex)) {
            final workingChunk = remainingChunks[onChunk];
            if (workingChunk.length + currentLength < currentPageEndIndex) {
              currentPage.add(workingChunk.textSpan);
              remainingSpans.remove(workingChunk.textSpan);
              currentLength += workingChunk.length;
              onChunk++;
            } else {
              // Create new span with part of the words, add it to the page, create new span with the remaining words, have that span replace the first one in the list, create new chunk with those remaining words, add it to the chunk list.
              final chunkWords = workingChunk.wordList;
              final additionalWords = <String>[];
              final nextWords = <String>[];
              var nextLine = false;
              for (final word in chunkWords) {
                // print('Word: $word');
                final wordLength = word.length;
                // print('${wordLength + currentLength} / $currentPageEndIndex');
                if (!nextLine &&
                    (currentLength + wordLength >= currentPageEndIndex)) {
                  nextLine = true;
                  // print('On to next line!');
                }
                if (!nextLine) {
                  additionalWords.add(word);
                  currentLength += word.length +
                      1; // Add one for the space, but will adjust this later to be cleaner
                } else {
                  nextWords.add(word);
                }
              }
              // print('New words: $additionalWords');
              // print('Next words: $nextWords');
              final newSpan = TextSpan(
                text: additionalWords.join(' '),
              );
              currentPage.add(newSpan);
              remainingSpans.remove(workingChunk.textSpan);
              final nextSpan = TextSpan(
                text: nextWords.join(' '),
              );
              remainingSpans.insert(0, nextSpan);
              remainingChunks.insert(
                onChunk + 1,
                WordChunk.buildWordChunk(textSpan: nextSpan),
              );
              numChunks++;
              onChunk++;

              break;
            }
          } // End WHILE through chunks for page
          pages.add(PageData(
            content: TextSpan(
              children: List.from(currentPage),
            ),
          ));
          // print('Page added. On chunk $onChunk of $numChunks');
          currentPage.clear();
          continue chunkLoop;
        } // End IF
      } // End FOR through each line

      // For adding the last page
      // Can only get here if the FOR loop did not end early
      pages.add(PageData(
        content: TextSpan(
          children: remainingSpans,
        ),
      ));
      break;
    } // End WHIlE through all chunks for all pages

    return pages;
  }

  static List<PageData> getPages({
    required String htmlContent,
    required double pageHeight,
    required double pageWidth,
    TextStyle defaultStyle = const TextStyle(),
  }) {
    final htmlDisplayTool = HtmlDisplayTool.fromHtml(htmlContent);
    final pages = htmlDisplayTool.pageBreaker(
      pageHeight: pageHeight,
      pageWidth: pageWidth,
      defaultStyle: defaultStyle,
    );
    return pages;
  }
}
