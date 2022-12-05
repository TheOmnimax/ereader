import 'package:ereader/utils/html_processor/html_utils/element_processor.dart';
import 'package:ereader/utils/html_processor/html_utils/helper_classes.dart';
import 'package:ereader/utils/html_processor/html_utils/used_classes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';

class HtmlDisplayTool {
  HtmlDisplayTool._({
    required this.textSpan,
  });

  final TextSpan textSpan;

  static HtmlDisplayTool fromHtml(String htmlContent) {
    // Start by clearing readability elements
    htmlContent = htmlContent.replaceAll(RegExp('[\n\r\t]'), '');
    htmlContent = htmlContent.replaceAll(RegExp(' {2,}'), ' ');

    final document = parse(htmlContent);

    final elementProcessor = ElementProcessor(document: document);

    return HtmlDisplayTool._(
      textSpan: elementProcessor.runProcessor(),
    );
  }

  // Creates a text painter that is used to determine which text is on which lines, which is used to determine when to break up the pages
  TextPainter _generatePainter({
    required TextSpan textSpan,
    required double maxWidth,
  }) {
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    )..layout(
        maxWidth: maxWidth,
      );
    return textPainter;
  }

  TextSpanDivision breaker({
    required TextSpan textSpan,
    required double pageHeight,
    required double pageWidth,
    TextStyle defaultStyle = const TextStyle(),
  }) {
    final textPainter = _generatePainter(
      textSpan: textSpan,
      maxWidth: pageWidth,
    );

    final lineMetrics = textPainter.computeLineMetrics();
    for (var i = 0; i < lineMetrics.length; i++) {
      final line = lineMetrics[i]; // Line metrics of the current line

      final left = line.left;
      final top = line.baseline - line.ascent;
      final bottom = line.baseline + line.descent;

      if (pageHeight < bottom) {
        // True if the content is too long for the page. If false, it means the content can fit, and it can simply be added without breaking up the page
        final currentPageEndIndex =
            textPainter.getPositionForOffset(Offset(left, top)).offset;

        final spanDivider = TextSpanDivider(
          workingSpan: textSpan,
          pageEndIndex: currentPageEndIndex,
        );
        final division = spanDivider.getDivision();
        return division;
      }
    }
    return TextSpanDivision(currentSpan: textSpan); // No division was necessary
  }

  List<PageData> pageBreaker({
    required double pageHeight,
    required double pageWidth,
    TextStyle defaultStyle = const TextStyle(),
  }) {
    final usedPageWidth =
        pageWidth - 3; // Subtract 3, or it may not calculate properly.

    final pages = <PageData>[];
    final workingSpan = textSpan.copyWith(style: defaultStyle);

    var spanDivision = breaker(
      pageHeight: pageHeight,
      pageWidth: usedPageWidth,
      textSpan: workingSpan,
    );
    pages.add(PageData(content: spanDivision.currentSpan));
    var nextSpan = spanDivision.nextSpan;
    while (nextSpan != null) {
      spanDivision = breaker(
        pageHeight: pageHeight,
        pageWidth: usedPageWidth,
        textSpan: nextSpan,
      );
      pages.add(PageData(content: spanDivision.currentSpan));
      nextSpan = spanDivision.nextSpan;
    }
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
