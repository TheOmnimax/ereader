import 'dart:io';

import 'package:epubx/epubx.dart';
import 'package:flutter/cupertino.dart';
import '../html_processor.dart';
import 'ebook_classes.dart';

class EbookProcessor {
  const EbookProcessor({
    required this.epubBook,
  });

  final EpubBook epubBook;

  static Future<EbookProcessor> fromPath(String path) async {
    final epubBook = await getEpubBook(path);
    return EbookProcessor(epubBook: epubBook);
  }

  static Future<EpubBook> getEpubBook(String path) async {
    final targetFile = File(path);
    final List<int> bytes = await targetFile.readAsBytes();
    final epubBook = await EpubReader.readBook(bytes);
    return epubBook;
  }

  EbookData getEbookData({
    required double pageHeight,
    required double pageWidth,
    required TextStyle style,
    String altTitle = '[unknown title]',
    String altAuthor = '[unknown author]',
  }) {
    PageChapterData pageChapterData = getPages(
      pageHeight: pageHeight,
      pageWidth: pageWidth,
      style: style,
    );
    return EbookData(
      title: epubBook.Title ?? altTitle,
      author: epubBook.Author ?? altAuthor,
      authorList: epubBook.AuthorList,
      pageData: pageChapterData.pageData,
      chapterData: pageChapterData.chapterData,
    );
  }

  PageChapterData getPages({
    required double pageHeight,
    required double pageWidth,
    required TextStyle style,
  }) {
    List<PageData> pages = <PageData>[];
    List<ChapterData> chapterData = <ChapterData>[];
    List<EpubChapter>? chapters = epubBook.Chapters;
    EpubContent? content = epubBook.Content;

    if (chapters != null) {
      for (final chapter in chapters) {
        // TODO: Add run through subchapters
        chapterData.add(
          ChapterData.generate(
            chapterData: chapter,
            start: pages.length,
          ),
        );
        final String? htmlContent = chapter.HtmlContent; // String?
        print('CHAPTER: ${chapter.Title}');
        if (htmlContent != null) {
          final newPages = HtmlDisplayTool.getPages(
            htmlContent: htmlContent,
            pageHeight: pageHeight,
            pageWidth: pageWidth,
            defaultStyle: style,
          );
          print(
              'There are ${newPages.length} new pages in the chapter ${chapter.Title}');
          pages.addAll(newPages);
        } else {
          pages.add(PageData(
              content: TextSpan())); // Add blank page if chapter has no content
        }
      }
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
            ));
          }
        }
      }
    } // End content check
    return PageChapterData(
      pageData: pages,
      chapterData: chapterData,
    );
  }
}
