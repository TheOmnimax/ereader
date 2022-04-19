import 'package:epubx/epubx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../html_processor.dart';

class EbookData {
  const EbookData({
    required this.title,
    required this.author,
    this.authorList,
    required this.pageData,
    required this.chapterData,
  });

  final String title;
  final String author;
  final List<String?>? authorList;
  final List<PageData> pageData;
  final List<ChapterData>
      chapterData; // A list of the page indexes in "pageData" where each chapter starts, so the user can jump ahead to each chapter

  EbookData redoPages({
    required PageChapterData pageChapterData,
  }) {
    return EbookData(
      title: title,
      author: author,
      authorList: authorList,
      pageData: pageChapterData.pageData,
      chapterData: pageChapterData.chapterData,
    );
  }
}

class PageChapterData {
  const PageChapterData({
    required this.pageData,
    required this.chapterData,
  });

  final List<PageData> pageData;
  final List<ChapterData> chapterData;
}

class ChapterData {
  const ChapterData._({
    required this.title,
    required this.start,
    this.anchor,
  });

  final String title;
  final int start; // Page index where the chapter starts;
  final String? anchor;

  static ChapterData generate({
    required EpubChapter chapterData,
    required int start,
  }) {
    String title = chapterData.Title ?? '';
    String? anchor = chapterData.Anchor;
    return ChapterData._(
      title: title,
      start: start,
      anchor: anchor,
    );
  }
}

class PageGenerator {
  PageGenerator(
      {required this.epubBook,
      required this.pageWidth,
      required this.pageHeight,
      required this.style});

  final EpubBook epubBook;
  final List<PageData> pages = <PageData>[];
  final chapterData = <ChapterData>[];
  final double pageWidth;
  final double pageHeight;
  final TextStyle style;

  void _chapterProcessor(List<EpubChapter> chapters) {
    for (final chapter in chapters) {
      // TODO: Add run through subchapters
      chapterData.add(
        ChapterData.generate(
          chapterData: chapter,
          start: pages.length,
        ),
      );
      final htmlContent = chapter.HtmlContent; // String?
      // print('CHAPTER: ${chapter.Title}');
      if (htmlContent != null) {
        final newPages = HtmlDisplayTool.getPages(
          htmlContent: htmlContent,
          pageHeight: pageHeight,
          pageWidth: pageWidth,
          defaultStyle: style,
        );
        // print(
        //     'There are ${newPages.length} new pages in the chapter ${chapter.Title}');
        pages.addAll(newPages);
      } else {
        pages.add(PageData(
            content: TextSpan())); // Add blank page if chapter has no content
      }
      final subChapters = chapter.SubChapters;
      if (subChapters != null) {
        _chapterProcessor(subChapters);
      }
    } // End FOR through each chapter
  }

  void generate() {
    final pages = <PageData>[];

    final chapters = epubBook.Chapters;
    final content = epubBook.Content;

    if (chapters != null) {
      _chapterProcessor(chapters);
    } else if (content != null) {
      // No chapters, so check content
      final contentHtmlMap = content.Html;
      if (contentHtmlMap != null) {
        for (final contentFileName in contentHtmlMap.keys) {
          final htmlContent = contentHtmlMap[contentFileName]?.Content;
          if (htmlContent != null) {
            // TODO: QUESTION: Could this be a function in a method, or is that not proper?
            // TODO: Make anonymous function
            pages.addAll(HtmlDisplayTool.getPages(
              htmlContent: htmlContent,
              pageHeight: pageHeight,
              pageWidth: pageWidth,
              defaultStyle: style,
            ));
          }
        }
      }
    }
  }
}
